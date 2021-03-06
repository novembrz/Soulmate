//
//  AuthFetcherServices.swift
//  Soulmate
//
//  Created by dasha on 19.01.2022.
//

import SwiftUI

struct AuthFetcherServices {
    
    static func signIn(login: String, password: String, completion: @escaping (Result, AuthToken?) -> Void) {
        NetworkService.postData(param: ["username": login.lowercased(),
                                        "password": password],
                                urlString: ServiceUrl.Auth.signIn,
                                completion: completion)
    }
    
    static func register(login: String, email: String, password: String, completion: @escaping (Result, AuthToken?) -> Void) {
        NetworkService.postData(param: ["username": login.lowercased(),
                                        "email": email.lowercased(),
                                        "password": password],
                                urlString: ServiceUrl.Auth.register,
                                completion: completion)
    }
    
    static func isFreeRegisterData(type: String, textData: String, completion: @escaping (Result, isFree?) -> Void) {
        NetworkService.postData(param: ["type": type,
                                        "text": textData],
                                urlString: ServiceUrl.Auth.isFreeData,
                                completion: completion)
    }
}



