import Foundation
import Capacitor
import ADAL

@available(iOS 13.0, *)
public class ADAuthentication {
    var kClientID: String;
    var kGraphURI: String;
    var kAuthority: String;
    var kRedirectUri = URL(string: "")
    var applicationContext : ADAuthenticationContext?

    let call: CAPPluginCall
    
    var detectedAlready = false
    
    public init(call: CAPPluginCall,  KClientID: String,kGraphURI: String,kAuthority: String,kRedirectUri: String) {
        self.call = call
        self.kClientID = KClientID
        self.kGraphURI = kGraphURI
        self.kAuthority = kAuthority
         CAPLog.print("kClientID fn: \(kClientID)");
         CAPLog.print("kRedirectUri fn: \(kRedirectUri)");
        self.kRedirectUri = URL(string: kRedirectUri)
        CAPLog.print("kRedirectUri: \(self.kRedirectUri)");
         self.applicationContext = ADAuthenticationContext(authority: kAuthority, error: nil)
        self.applicationContext?.credentialsType = AD_CREDENTIALS_AUTO
    }

    public func initADAL() {
        // fail out if call is already used up
         guard let applicationContext = self.applicationContext else { return }
        guard let kRedirectUri = kRedirectUri else { return }
        applicationContext.acquireToken(withResource: kGraphURI, clientId: kClientID, redirectUri: kRedirectUri){ (result) in
            if (result.status != AD_SUCCEEDED) {
                if let error = result.error {
                    if error.domain == ADAuthenticationErrorDomain,
                        error.code == ADErrorCode.ERROR_UNEXPECTED.rawValue {
                        CAPLog.print("Unexpected internal error occured: \(error.description)")
                        self.call.reject("Unexpected internal error occured: \(error.description)")
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

    public func acquireTokenSilently() {
        
        guard let applicationContext = self.applicationContext else { return }
        guard let kRedirectUri = kRedirectUri else { return }

        applicationContext.acquireTokenSilent(withResource: kGraphURI, clientId: kClientID, redirectUri: kRedirectUri) { (result) in
            if (result.status != AD_SUCCEEDED) {
                if let error = result.error {
                    if error.domain == ADAuthenticationErrorDomain,
                        error.code == ADErrorCode.ERROR_SERVER_USER_INPUT_NEEDED.rawValue {
                        
                        DispatchQueue.main.async {
                            self.initADAL()
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
    public func currentAccount() {
        guard let cachedTokens = ADKeychainTokenCache.defaultKeychain().allItems(nil) else {
             CAPLog.print("Didn't find a default cache. This is very unusual.")
            self.call.reject("Didn't find a default cache. This is very unusual.")
            return
        }
        if !(cachedTokens.isEmpty) {
            for (_, cachedToken) in cachedTokens.enumerated() {
                if cachedToken.accessToken != nil {
                  self.call.success(["cachedToken": cachedToken])
                }
            }
        }
    }
    public func signOut() {
        
        /**
         Removes all tokens from the cache for this application for the current account in use
         - account:    The account user ID to remove from the cache
         */
        guard let account = currentAccount()?.userInformation?.userId else {
             CAPLog.print("Didn't find a logged in account in the cache.")
             self.call.reject("Didn't find a logged in account in the cache.")
           
            return
        }
        ADKeychainTokenCache.defaultKeychain().removeAll(forUserId: account, clientId: kClientID, error: nil)
        self.call.success(["success": true])
    }
   
}
