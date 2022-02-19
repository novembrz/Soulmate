//
//  KeychainModels.swift
//  Soulmate
//
//  Created by dasha on 17.02.2022.
//

import Foundation

struct AuthToken: Codable {
    let token: String
    let refreshToken: String
}

//MARK: Зачем
struct SignInResponse: Decodable, Encodable { //вернет при сайн ин только токен, если еще что-то надо - расширяй
    let accessToken: String
}

struct Credentials: Codable {
    var username: String
    var password: String
}
