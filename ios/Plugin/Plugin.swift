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
        
          guard var KClientID = call.getString("ClientID") else {
            call.reject("ClientID not found")
            return
        }
        guard var kGraphURI = call.getString("GraphURI") else {
            call.reject("GraphURI not found")
            return
        }

     guard var kAuthority = call.getString("Authority") else {
            call.reject("Authority not found")
            return
        }

        guard var kRedirectUri = call.getString("RedirectUri") else {
            call.reject("RedirectUri not found")
            return
        }
       ADAuthentication(call: call, KClientID:String,kGraphURI: String,kAuthority: String,kRedirectUri: String).initADAL()
    }
}
