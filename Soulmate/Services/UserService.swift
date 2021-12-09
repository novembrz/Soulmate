//
//  UserService.swift
//  Soulmate
//
//  Created by dasha on 29.11.2021.
//

import SwiftUI

class UserService {
    
    static let shared = UserService()
    
    private init() {}
    
    func followUser() {
        print(#function)
    }
}

class UserServices {
    
    static func followUser() {
        print(#function)
    }
}
