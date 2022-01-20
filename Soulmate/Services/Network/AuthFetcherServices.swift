//
//  AuthFetcherServices.swift
//  Soulmate
//
//  Created by dasha on 19.01.2022.
//

import SwiftUI

struct AuthFetcherServices {
    
    static var authURL = "http://localhost:8082/api/auth/"
    
    static func signIn(login: String, password: String, completion: @escaping (Result) -> Void) {
        let urlString = authURL + "signin"
        NetworkService.postData(param: ["username": login.lowercased(), "password": password], urlString: urlString, completion: completion)
    }
}
