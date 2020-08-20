import { Plugins } from '@capacitor/core';
const { MSALiOS } = Plugins;

export class ADAuthentication implements acquireTokenInteractivelyInterface {
  async initADAL(
    ClientID: string,
    GraphURI: string,
    Authority: string,
    RedirectUri: string,
  ): Promise<IAuthenticationResult[]> {
    const response = await MSALiOS.initADAL({
      ClientID,
      GraphURI,
      Authority,
      RedirectUri,
    });
    return response.accessToken;
  }
}

export interface acquireTokenInteractivelyInterface {
  initADAL(
    ClientID: string,
    GraphURI: string,
    Authority: string,
    RedirectUri: string,
  ): Promise<IAuthenticationResult[]>;
}
export interface IAuthenticationResult {
  accessToken: string;
}
