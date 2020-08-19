import '@capacitor/core';

declare module '@capacitor/core' {
  interface PluginRegistry {
    MSALiOS: {};
  }
}

export default {};
