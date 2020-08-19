declare module '@capacitor/core' {
    interface PluginRegistry {
        MSALiOS: MSALiOSPlugin;
    }
}
export interface MSALiOSPlugin {
    initMSAL(options: {
        authorityURL: string;
    }): Promise<{
        authorityURL: string;
    }>;
    callGraphAPI(options: {
        authorityURL: string;
    }): Promise<{
        AccessToken: string;
    }>;
    acquireTokenInteractively(options: {
        authorityURL: string;
    }): Promise<{
        AccessToken: string;
    }>;
    acquireTokenSilently(): Promise<{
        AccessToken: string;
    }>;
}
