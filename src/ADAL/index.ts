import { Plugins } from '@capacitor/core';
const { MSALiOS } = Plugins;

export class ADAuthentication implements acquireTokenInteractivelyInterface {
  async initADAL(
    ClientID: String,
    GraphURI: String,
    Authority: String,
    RedirectUri: String,
  ): Promise<IAuthenticationResult[]> {
    const response = await MSALiOS.initADAL({
      ClientID,
      GraphURI,
      Authority,
      RedirectUri,
    });
    return response.accessToken;
  }
  async aquireTokenAsyncSilent(
    ClientID: String,
    GraphURI: String,
    Authority: String,
    RedirectUri: String,
  ): Promise<IAuthenticationResult[]> {
    const response = await MSALiOS.aquireTokenAsyncSilent({
      ClientID,
      GraphURI,
      Authority,
      RedirectUri,
    });
    return response.accessToken;
  }

  async currentAccount(
    ClientID: String,
    GraphURI: String,
    Authority: String,
    RedirectUri: String,
  ): Promise<any[]> {
    const response = await MSALiOS.currentAccount({
      ClientID,
      GraphURI,
      Authority,
      RedirectUri,
    });
    return response.cachedToken;
  }
  async signOut(
    ClientID: String,
    GraphURI: String,
    Authority: String,
    RedirectUri: String,
  ): Promise<any[]> {
    const response = await MSALiOS.signOut({
      ClientID,
      GraphURI,
      Authority,
      RedirectUri,
    });
    return response.cachedToken;
  }
}

export interface acquireTokenInteractivelyInterface {
  initADAL(
    ClientID: string,
    GraphURI: string,
    Authority: string,
    RedirectUri: string,
  ): Promise<IAuthenticationResult[]>;
  aquireTokenAsyncSilent(
    ClientID: string,
    GraphURI: string,
    Authority: string,
    RedirectUri: string,
  ): Promise<IAuthenticationResult[]>;
  currentAccount(
    ClientID: string,
    GraphURI: string,
    Authority: string,
    RedirectUri: string,
  ): Promise<any[]>;
  signOut(
    ClientID: string,
    GraphURI: string,
    Authority: string,
    RedirectUri: string,
  ): Promise<any[]>;
}
export interface IAuthenticationResult {
  accessToken: string;
}

export interface OAuth2AuthenticateBaseOptions {
  /**
   * The app id (client id) you get from the oauth provider like Google, Facebook,...
   *
   * required!
   */
  clientID: string;
  /**
   * The base url for retrieving tokens depending on the response type from a OAuth 2 provider. e.g. https://accounts.google.com/o/oauth2/auth
   *
   * required!
   */
  graphURI: string;
  /**
   * Tells the authorization server which grant to execute. Be aware that a full code flow is not supported as clientCredentials are not included in requests.
   *
   * But you can retrieve the authorizationCode if you don't set a accessTokenEndpoint.
   *
   * required!
   */
  authority: string;
  /**
   * Url to  which the oauth provider redirects after authentication.
   *
   * required!
   */
  redirectUri: string;
  scope?: string;
  /**
   * A unique alpha numeric string used to prevent CSRF. If not set the plugin automatically generate a string
   * and sends it as using state is recommended.
   */
  state?: string;
  /**
   * Additional parameters for the created authorization url
   */
  additionalParameters?: { [key: string]: string };
}
