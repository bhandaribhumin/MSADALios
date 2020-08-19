import { WebPlugin } from '@capacitor/core';
import { MSALiOSPlugin } from './definitions';

export class MSALiOSWeb extends WebPlugin implements MSALiOSPlugin {
  constructor() {
    super({
      name: 'MSALiOS',
      platforms: ['web'],
    });
  }

  async initMSAL(options: {
    authorityURL: string;
  }): Promise<{ authorityURL: string }> {
    console.log('initMSAL', options);
    return options;
  }
  async callGraphAPI(): Promise<{ AccessToken: string }> {
    console.log('callGraphAPI');
    const AccessToken = {
      AccessToken: 'test',
    };
    return AccessToken;
  }
  async acquireTokenInteractively(): Promise<{ AccessToken: string }> {
    const AccessToken = {
      AccessToken: 'test',
    };
    return AccessToken;
  }

  async acquireTokenSilently(): Promise<{ AccessToken: string }> {
    const AccessToken = {
      AccessToken: 'test',
    };
    return AccessToken;
  }
}

const MSALiOS = new MSALiOSWeb();

export { MSALiOS };

import { registerWebPlugin } from '@capacitor/core';
registerWebPlugin(MSALiOS);
