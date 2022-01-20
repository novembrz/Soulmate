//
//  UserProfession.swift
//  Soulmate
//
//  Created by dasha on 19.01.2022.
//

import Foundation


struct UserProfessions: Decodable, Identifiable, Equatable {
    var id: Int
    var name: String
    var main: Bool
    var position: Int
    var userProfessionId: Int?
    var worksCount: Int?
    var folderCount: Int?
}


extension UserProfessions: Hashable {
    static func == (lhs: UserProfessions, rhs: UserProfessions) -> Bool {
        return lhs.id == rhs.id
    }
}
