export declare class MsAdal implements acquireTokenInteractivelyInterface {
    acquireTokenInteractively(): Promise<IAuthenticationResult[]>;
    callGraphAPI(): Promise<IAuthenticationResult[]>;
}
export interface acquireTokenInteractivelyInterface {
    acquireTokenInteractively(): Promise<IAuthenticationResult[]>;
    callGraphAPI(): Promise<IAuthenticationResult[]>;
}
export interface IAuthenticationResult {
    accessToken: string;
    accessTokenType: string;
    expiresOn: Date;
    idToken: string;
    isMultipleResourceRefreshToken?: boolean;
    status?: string;
    statusCode?: string;
    tenantId?: string;
    userInfo?: IUserInfo;
}
/**
 * @description Interface for classes that represent a users info.
 * @interface IUserInfo
 */
export interface IUserInfo {
    displayableId: string;
    userId: string;
    familyName: string;
    givenName: string;
    identityProvider: string;
    passwordChangeUrl?: string;
    passwordExpiresOn: Date;
    uniqueId: string;
}
