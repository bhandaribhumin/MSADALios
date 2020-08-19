import { WebPlugin } from '@capacitor/core';
import { MSALiOSPlugin } from './definitions';

export class MSALiOSWeb extends WebPlugin implements MSALiOSPlugin {
  constructor() {
    super({
      name: 'MSALiOS',
      platforms: ['web'],
    });
  }

  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
}

const MSALiOS = new MSALiOSWeb();

export { MSALiOS };

import { registerWebPlugin } from '@capacitor/core';
registerWebPlugin(MSALiOS);
