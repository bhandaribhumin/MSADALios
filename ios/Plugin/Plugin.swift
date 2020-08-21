import Foundation
import Capacitor
import ADAL
/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(MSALiOS)
public class MSALiOS: CAPPlugin {
    @objc func initADAL(_ call: CAPPluginCall) {
        
          guard let KClientID = call.getString("ClientID") else {
            call.reject("ClientID not found")
            return
        }
        guard let kGraphURI = call.getString("GraphURI") else {
            call.reject("GraphURI not found")
            return
        }

     guard let kAuthority = call.getString("Authority") else {
            call.reject("Authority not found")
            return
        }

        guard var kRedirectUri = call.getString("RedirectUri") else {
            call.reject("RedirectUri not found")
            return
        }
        if #available(iOS 13.0, *) {
            DispatchQueue.main.async {
                ADAuthentication(call: call, KClientID: KClientID,kGraphURI: kGraphURI,kAuthority: kAuthority,kRedirectUri: kRedirectUri).initADAL()
            }
           
        } else {
            // Fallback on earlier versions
        }
    }

    @objc func aquireTokenAsyncSilent(_ call: CAPPluginCall) {
        
          guard let KClientID = call.getString("ClientID") else {
            call.reject("ClientID not found")
            return
        }
        guard let kGraphURI = call.getString("GraphURI") else {
            call.reject("GraphURI not found")
            return
        }

     guard let kAuthority = call.getString("Authority") else {
            call.reject("Authority not found")
            return
        }

        guard var kRedirectUri = call.getString("RedirectUri") else {
            call.reject("RedirectUri not found")
            return
        }
        if #available(iOS 13.0, *) {
            DispatchQueue.main.async {
                ADAuthentication(call: call, KClientID: KClientID,kGraphURI: kGraphURI,kAuthority: kAuthority,kRedirectUri: kRedirectUri).acquireTokenSilently()
            }
           
        } else {
            // Fallback on earlier versions
        }
    }

     @objc func currentAccount(_ call: CAPPluginCall) {
        
          guard let KClientID = call.getString("ClientID") else {
            call.reject("ClientID not found")
            return
        }
        guard let kGraphURI = call.getString("GraphURI") else {
            call.reject("GraphURI not found")
            return
        }

     guard let kAuthority = call.getString("Authority") else {
            call.reject("Authority not found")
            return
        }

        guard var kRedirectUri = call.getString("RedirectUri") else {
            call.reject("RedirectUri not found")
            return
        }
        if #available(iOS 13.0, *) {
            DispatchQueue.main.async {
                ADAuthentication(call: call, KClientID: KClientID,kGraphURI: kGraphURI,kAuthority: kAuthority,kRedirectUri: kRedirectUri).currentAccount()
            }
           
        } else {
            // Fallback on earlier versions
        }
    }

     @objc func signOut(_ call: CAPPluginCall) {
        
          guard let KClientID = call.getString("ClientID") else {
            call.reject("ClientID not found")
            return
        }
        guard let kGraphURI = call.getString("GraphURI") else {
            call.reject("GraphURI not found")
            return
        }

     guard let kAuthority = call.getString("Authority") else {
            call.reject("Authority not found")
            return
        }

        guard var kRedirectUri = call.getString("RedirectUri") else {
            call.reject("RedirectUri not found")
            return
        }
        if #available(iOS 13.0, *) {
            DispatchQueue.main.async {
                ADAuthentication(call: call, KClientID: KClientID,kGraphURI: kGraphURI,kAuthority: kAuthority,kRedirectUri: kRedirectUri).signOut()
            }
           
        } else {
            // Fallback on earlier versions
        }
    }
    
}
