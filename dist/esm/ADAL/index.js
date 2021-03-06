var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
import { Plugins } from '@capacitor/core';
const { MSALiOS } = Plugins;
export class ADAuthentication {
    initADAL(ClientID, GraphURI, Authority, RedirectUri) {
        return __awaiter(this, void 0, void 0, function* () {
            const response = yield MSALiOS.initADAL({
                ClientID,
                GraphURI,
                Authority,
                RedirectUri,
            });
            return response.accessToken;
        });
    }
    aquireTokenAsyncSilent(ClientID, GraphURI, Authority, RedirectUri) {
        return __awaiter(this, void 0, void 0, function* () {
            const response = yield MSALiOS.aquireTokenAsyncSilent({
                ClientID,
                GraphURI,
                Authority,
                RedirectUri,
            });
            return response.accessToken;
        });
    }
    currentAccount(ClientID, GraphURI, Authority, RedirectUri) {
        return __awaiter(this, void 0, void 0, function* () {
            const response = yield MSALiOS.currentAccount({
                ClientID,
                GraphURI,
                Authority,
                RedirectUri,
            });
            return response.cachedToken;
        });
    }
    signOut(ClientID, GraphURI, Authority, RedirectUri) {
        return __awaiter(this, void 0, void 0, function* () {
            const response = yield MSALiOS.signOut({
                ClientID,
                GraphURI,
                Authority,
                RedirectUri,
            });
            return response.cachedToken;
        });
    }
}
//# sourceMappingURL=index.js.map