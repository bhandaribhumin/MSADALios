import Foundation
import Capacitor
import ADAL

@available(iOS 13.0, *)
public class ADAuthentication {
    var kClientID = ""
    var kGraphURI = ""
    var kAuthority = ""
    var kRedirectUri = URL(string: "")
    var applicationContext : ADAuthenticationContext?

    let call: CAPPluginCall
    
    var detectedAlready = false
    
    public init(call: CAPPluginCall,  KClientID:String,kGraphURI: String,kAuthority: String,kRedirectUri: String) {
        self.call = call
        self.kClientID = KClientID
        self.kGraphURI = kGraphURI
        self.kAuthority = kAuthority
         self.kRedirectUri = URL(string: kRedirectUri)
           CAPLog.print("Unexpected kRedirectUri: \(self.kRedirectUri))");
         self.applicationContext = ADAuthenticationContext(authority: kAuthority, error: nil)
        self.applicationContext?.credentialsType = AD_CREDENTIALS_AUTO
    }

    public func initADAL() {
        // fail out if call is already used up
         guard let applicationContext = self.applicationContext else { return }
        guard let kRedirectUri = kRedirectUri else { return }
        applicationContext.acquireToken(withResource: kGraphURI, clientId: kClientID, redirectUri: kRedirectUri!){ (result) in
            if (result.status != AD_SUCCEEDED) {
                if let error = result.error {
                    if error.domain == ADAuthenticationErrorDomain,
                        error.code == ADErrorCode.ERROR_UNEXPECTED.rawValue {
                        CAPLog.print("Unexpected internal error occured: \(error.description))")
                        self.call.reject("Unexpected internal error occured: \(error.description))")
                        return
                    } else {
                        CAPLog.print(error.description)
                        self.call.reject(error.description)
                        return
                    }
                }
               self.call.reject("ApplicationContext AcquireToken Reject")
                return
            } else {
                CAPLog.print("Access token is \(String(describing: result.accessToken))")
            self.call.success(["accessToken": result.accessToken])
            }
        }
    }

    func acquireTokenSilently() {
        
        guard let applicationContext = self.applicationContext else { return }
        guard let kRedirectUri = kRedirectUri else { return }

        applicationContext.acquireTokenSilent(withResource: kGraphURI, clientId: kClientID, redirectUri: kRedirectUri!) { (result) in
            if (result.status != AD_SUCCEEDED) {
                if let error = result.error {
                    if error.domain == ADAuthenticationErrorDomain,
                        error.code == ADErrorCode.ERROR_SERVER_USER_INPUT_NEEDED.rawValue {
                        
                        DispatchQueue.main.async {
                            self.acquireToken() { (success) -> Void in
                                if success {
                                   self.call.success(true)
                                } else {
                                CAPLog.print("After determining we needed user input, could not acquire token: \(error.description)")
                                 self.call.reject("After determining we needed user input, could not acquire token: \(error.description)")
                                }
                            }
                        }
                    } else {
                        CAPLog.print("Could not acquire token silently: \(error.description)")
                       self.call.reject("Could not acquire token silently: \(error.description)")
                    }
                }
            
            } else {
                CAPLog.print("Refreshed Access token is \(String(describing: result.accessToken))")
                 self.call.success(["accessToken": result.accessToken])
            }
        }
    }
     func currentAccount() {
        guard let cachedTokens = ADKeychainTokenCache.defaultKeychain().allItems(nil) else {
             CAPLog.print("Didn't find a default cache. This is very unusual.")
            self.call.reject("Didn't find a default cache. This is very unusual.")
            return
        }
        if !(cachedTokens.isEmpty) {
            for (_, cachedToken) in cachedTokens.enumerated() {
                if cachedToken.accessToken != nil {
                    self.call.success(["cachedToken": cachedToken])
                    return cachedToken
                }
            }
        }
    }
   
}
