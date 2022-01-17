//
//  UserModel.swift
//  Soulmate
//
//  Created by dasha on 05.12.2021.
//

import Foundation


struct UserModel: Decodable {
    var id: Int
    var username: String
    var firstName: String
    var lastName: String
    var city: String?
    var age: Int?
    var color: String?
    var description: String?
    var views: Int?
    var professions: [UserProfessions]?
    var avatars: [Avatars]?
    var totalWorks: Int?
    var totalSubscribers: Int?
    var totalLikes: Int?
}

struct UserProfessions: Decodable, Identifiable, Equatable {
    var id: Int
    var name: String
    var main: Bool
    var position: Int
    var userProfessionId: Int
    var worksCount: Int
    var folderCount: Int
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
