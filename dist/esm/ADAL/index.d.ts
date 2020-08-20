export declare class ADAuthentication implements acquireTokenInteractivelyInterface {
    initADAL(ClientID: string, GraphURI: string, Authority: string, RedirectUri: string): Promise<IAuthenticationResult[]>;
}
export interface acquireTokenInteractivelyInterface {
    initADAL(ClientID: string, GraphURI: string, Authority: string, RedirectUri: string): Promise<IAuthenticationResult[]>;
}
export interface IAuthenticationResult {
    accessToken: string;
}
