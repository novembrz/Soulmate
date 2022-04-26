//
//  UserDefaultsProperties.swift
//  Soulmate
//
//  Created by dasha on 26.04.2022.
//

import Foundation


struct UserDefaultsProperties {
    @Storage(key: UserDefaultsKeys.walkthrough.rawValue, defaultValue: false)
    static var walkthroughShown: Bool
}


//MARK: - UserDefaultsKeys

enum UserDefaultsKeys: String, Codable {
    case walkthrough = "Walkthrough"
}


/*
 get - UDProperty.user
 set - UDProperty.username = "swift-senpai"
 remove - UserDefaultsProperties.removeBy(key: "")
*/
