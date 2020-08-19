import { WebPlugin } from '@capacitor/core';
import { MSALiOSPlugin } from './definitions';
export declare class MSALiOSWeb extends WebPlugin implements MSALiOSPlugin {
    constructor();
    initMSAL(options: {
        authorityURL: string;
    }): Promise<{
        authorityURL: string;
    }>;
    callGraphAPI(): Promise<{
        AccessToken: string;
    }>;
    acquireTokenInteractively(): Promise<{
        AccessToken: string;
    }>;
    acquireTokenSilently(): Promise<{
        AccessToken: string;
    }>;
}
declare const MSALiOS: MSALiOSWeb;
export { MSALiOS };
