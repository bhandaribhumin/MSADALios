import { WebPlugin } from '@capacitor/core';
import { MSALiOSPlugin } from './definitions';
export declare class MSALiOSWeb extends WebPlugin implements MSALiOSPlugin {
    constructor();
    echo(options: {
        value: string;
    }): Promise<{
        value: string;
    }>;
}
declare const MSALiOS: MSALiOSWeb;
export { MSALiOS };
