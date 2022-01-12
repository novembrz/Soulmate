//
//  UserModel.swift
//  Soulmate
//
//  Created by dasha on 05.12.2021.
//

import Foundation


struct UserModel: Decodable {
    var path: String? // future deprecated
    var id: Int
    var username: String
    var firstName: String
    var lastName: String
    var city: String?
    var age: Int?
    var color: String?
    var description: String?
    var views: Int?
    var userProfessions: [UserProfessions]?
    var avatars: [Avatars]?
    var totalWorks: Int?
    var totalSubscribers: Int?
    var totalLikes: Int?
}

/*
 "author": {
     "path": null,
     "id": 1,
     "username": "yar",
     "firstName": "Ярослав",
     "lastName": "Девятовский",
     "age": 22,
     "city": "Илькино",
     "color": "#903F3C",
     "description": "I am programmer",
     "views": 3,
     "avatars": [
         {}
     ]
 }
 */


struct UserProfessions: Decodable, Identifiable, Equatable {
    var name: String
    var main: Bool
    var id: Int
    var position: Int
}


struct Avatars: Decodable {
    var link: String?
    var main: Bool?
}


extension UserModel: Hashable {
    static func == (lhs: UserModel, rhs: UserModel) -> Bool {
        return lhs.id == rhs.id
    }
}

extension UserProfessions: Hashable {
    static func == (lhs: UserProfessions, rhs: UserProfessions) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Avatars: Hashable {
    static func == (lhs: Avatars, rhs: Avatars) -> Bool {
        return lhs.link == rhs.link
    }
}
