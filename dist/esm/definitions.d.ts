declare module '@capacitor/core' {
    interface PluginRegistry {
        MSALiOS: MSALiOSPlugin;
    }
}
export interface MSALiOSPlugin {
    echo(options: {
        value: string;
    }): Promise<{
        value: string;
    }>;
}
