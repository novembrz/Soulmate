//
//  UserProfession.swift
//  Soulmate
//
//  Created by dasha on 19.01.2022.
//

import Foundation


protocol ProfessionProtocol {
    var id: Int { get }
    var name: String { get set }
    var main: Bool { get set }
}


struct UserProfessions: ProfessionProtocol, Decodable, Identifiable, Equatable {
    var id: Int
    var name: String
    var main: Bool
    var position: Int
    var userProfessionId: Int?
    var worksCount: Int?
    var folderCount: Int?
}


struct Profession: ProfessionProtocol, Decodable, Identifiable, Hashable {
    var uuid = UUID().uuidString
    var id: Int
    var name: String
    var main: Bool
    var isExceeded = false
}


extension UserProfessions: Hashable {
    static func == (lhs: UserProfessions, rhs: UserProfessions) -> Bool {
        return lhs.id == rhs.id
    }
}
