//
//  KeychainModels.swift
//  Soulmate
//
//  Created by dasha on 17.02.2022.
//

import Foundation

struct AuthToken: Codable {
    let accessToken: String
    let refreshToken: String
}


struct Credentials: Codable {
    var username: String
    var password: String
}
