#import <Foundation/Foundation.h>
#import <Capacitor/Capacitor.h>

// Define the plugin using the CAP_PLUGIN Macro, and
// each method the plugin supports using the CAP_PLUGIN_METHOD macro.
CAP_PLUGIN(MSALiOS, "MSALiOS",
            CAP_PLUGIN_METHOD(initADAL, CAPPluginReturnPromise);
            CAP_PLUGIN_METHOD(aquireTokenAsyncSilent, CAPPluginReturnPromise);
            CAP_PLUGIN_METHOD(currentAccount, CAPPluginReturnPromise);
            CAP_PLUGIN_METHOD(signOut, CAPPluginReturnPromise);
            
)
