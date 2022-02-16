//
//  AuthFetcherServices.swift
//  Soulmate
//
//  Created by dasha on 19.01.2022.
//

import SwiftUI

struct AuthFetcherServices {
    
    static private var authURL = "http://localhost:8082/api/auth/"
    
    static func signIn(login: String, password: String, completion: @escaping (Result) -> Void) {
        let urlString = authURL + "signin"
        NetworkService.postData(param: ["username": login.lowercased(), "password": password], urlString: urlString, completion: completion)
    }
    
    static func register(login: String, email: String, password: String, completion: @escaping (Result) -> Void) {
        print("🥦", password)
        let urlString = authURL + "signup"
        NetworkService.postData(param: ["username": login.lowercased(),
                                        "email": email.lowercased(),
                                        "password": password],
                                urlString: urlString,
                                completion: completion)
    }
    
}
