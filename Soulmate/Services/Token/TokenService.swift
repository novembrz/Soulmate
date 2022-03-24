//
//  TokenService.swift
//  Soulmate
//
//  Created by dasha on 20.02.2022.
//

import Foundation

final class TokenService {
    var accessToken: String?
    static let standard = TokenService()
    
    private init() {}
    
    func didRefreshTokensMatch(completion: @escaping (Result) -> Void) {
        guard let readData = KeychainService.standard.read(account: "token", type: AuthToken.self)
        else { return completion(.failure(KeychainServiceError.readError)) }

        checkRefreshToken(readData.refreshToken) { result, authToken in
            switch result {
            case .success:
                guard let token = authToken else { return }
                KeychainService.standard.save(token, account: "token")
                self.accessToken = token.accessToken
                print("🔋", token.accessToken)
                completion(.success)
            case .failure(let authError):
                print("☎️", KeychainServiceError.checkRefreshToken, authError.localizedDescription)
                completion(.failure(KeychainServiceError.checkRefreshToken))
            }
        }
    }
    
    private func checkRefreshToken(_ refreshToken: String, completion: @escaping (Result, AuthToken?) -> Void) { //Bool?
        NetworkService.postData(param: ["refreshToken": refreshToken],
                                urlString: ServiceUrl.Auth.refreshToken,
                                completion: completion)
    }
}
