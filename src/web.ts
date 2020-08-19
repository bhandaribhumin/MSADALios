import { WebPlugin } from '@capacitor/core';
import { IAuthenticationResult } from './ADAL/index';

export class MSALiOSWeb extends WebPlugin {
  constructor() {
    super({
      name: 'MSALiOS',
      platforms: ['web'],
    });
  }
  async acquireTokenInteractively(
    clientID: string,
    redirectURL: string,
  ): Promise<IAuthenticationResult[]> {
    return Promise.reject('Web Plugin Not implemented');
  }
}

const MSALiOS = new MSALiOSWeb();

export { MSALiOS };

import { registerWebPlugin } from '@capacitor/core';
registerWebPlugin(MSALiOS);
