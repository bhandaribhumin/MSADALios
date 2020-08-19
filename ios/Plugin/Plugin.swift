import Foundation
import Capacitor
import MSAL
/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(MSALiOS)
public class MSALiOS: CAPPlugin {

    let kClientID = "16546c77-4e85-450e-8cc8-0049c57be748"
    let kGraphEndpoint = "https://graph.microsoft.com/"
    let kAuthority = "https://login.microsoftonline.com/2ffc2ede-4d44-4994-8082-487341fa43fb"
    let kRedirectUri = "msauth.com.rti.adal://auth"
    
    let kScopes: [String] = ["user.read"]
    
    var accessToken = String()
    var applicationContext : MSALPublicClientApplication?
     var webViewParamaters : MSALWebviewParameters?
var currentAccount: MSALAccount?
    @objc func initMSAL(_ call: CAPPluginCall) {
        guard var authorityURL = call.getString("authorityURL") else {
            call.reject("authority URL not found")
            return
        }
        call.success([
            "authorityURL": authorityURL
        ])
    }
    @objc func callGraphAPI() {
        
        self.loadCurrentAccount { (account) in
            
            guard let currentAccount = account else {
                
                // We check to see if we have a current logged in account.
                // If we don't, then we need to sign someone in.
                self.acquireTokenInteractively()
                return
            }
            
            self.acquireTokenSilently(currentAccount)
        }
    }

    func acquireTokenInteractively() {
        
        guard let applicationContext = self.applicationContext else { return }
        guard let webViewParameters = self.webViewParamaters else { return }

        let parameters = MSALInteractiveTokenParameters(scopes: kScopes, webviewParameters: webViewParameters)
        parameters.promptType = .selectAccount
        
        applicationContext.acquireToken(with: parameters) { (result, error) in
            
            if let error = error {
                print("Could not acquire token")
                return
            }
            
            guard let result = result else {
                
                print("Could not acquire token: No result returned")
                return
            }
            
            self.accessToken = result.accessToken
            print("Access token is \(self.accessToken)")
            call.success([
            self.accessToken
            ])
            self.updateCurrentAccount(account: result.account)
            self.getContentWithToken()
        }
    }
    
    func acquireTokenSilently(_ account : MSALAccount!) {
        
        guard let applicationContext = self.applicationContext else { return }
        
        /**
         
         Acquire a token for an existing account silently
         
         - forScopes:           Permissions you want included in the access token received
         in the result in the completionBlock. Not all scopes are
         guaranteed to be included in the access token returned.
         - account:             An account object that we retrieved from the application object before that the
         authentication flow will be locked down to.
         - completionBlock:     The completion block that will be called when the authentication
         flow completes, or encounters an error.
         */
        
        let parameters = MSALSilentTokenParameters(scopes: kScopes, account: account)
        
        applicationContext.acquireTokenSilent(with: parameters) { (result, error) in
            
            if let error = error {
                
                let nsError = error as NSError
                
                // interactionRequired means we need to ask the user to sign-in. This usually happens
                // when the user's Refresh Token is expired or if the user has changed their password
                // among other possible reasons.
                
                if (nsError.domain == MSALErrorDomain) {
                    
                    if (nsError.code == MSALError.interactionRequired.rawValue) {
                        
                        DispatchQueue.main.async {
                            self.acquireTokenInteractively()
                        }
                        return
                    }
                }
                
                print("Could not acquire token silently: \(error)")
                return
            }
            
            guard let result = result else {
                
                print("Could not acquire token: No result returned")
                return
            }
            
            self.accessToken = result.accessToken
              print("Refreshed Access token is \(self.accessToken)")
           call.success([
            self.accessToken
            ])
          
            self.getContentWithToken()
        }
    }
     func getGraphEndpoint() -> String {
        return kGraphEndpoint.hasSuffix("/") ? (kGraphEndpoint + "v1.0/me/") : (kGraphEndpoint + "/v1.0/me/");
    }
    
     func getContentWithToken() {
        
        // Specify the Graph API endpoint
        let graphURI = getGraphEndpoint()
        let url = URL(string: graphURI)
        var request = URLRequest(url: url!)
        
        // Set the Authorization header for the request. We use Bearer tokens, so we specify Bearer + the token we got from the result
        request.setValue("Bearer \(self.accessToken)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                print("Couldn't get graph result: \(error)")
                return
            }
            
            guard let result = try? JSONSerialization.jsonObject(with: data!, options: []) else {
                
                print("Couldn't deserialize result JSON")
                return
            }
            
            print("Result from Graph: \(result))")
            
            }.resume()
    }
    func updateCurrentAccount(account: MSALAccount?) {
        self.currentAccount = account
    }
}
