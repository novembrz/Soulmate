//
//  UserModel.swift
//  Soulmate
//
//  Created by dasha on 05.12.2021.
//

import Foundation

//Если есть возможность, то сократить до первых 4 и 6 полей - прим 

struct UserModel: Decodable {
    var id: Int
    var username: String
    var firstName: String?
    var lastName: String?
    var professions: [UserProfessions]?
    var avatars: [Avatars]?
    var city: String?
    var age: Int?
    var color: String?
    var description: String?
    var views: Int?
    var totalWorks: Int?
    var totalSubscribers: Int?
    var totalLikes: Int?
}


//MARK: - Extension

extension UserModel: Hashable {
    static func == (lhs: UserModel, rhs: UserModel) -> Bool {
        return lhs.id == rhs.id
    }
}

/*
 protocol UserProtocol {
     var id: Int { get }
     var username: String { get set }
     var firstName: String? { get set }
     var lastName: String? { get set }
    // var professions: [UserProfessions]? { get set }
     //var avatars: [Avatars]? { get set }
 }


 struct HomeUser: UserProtocol, Decodable, Identifiable, Equatable {
     var id: Int
     var username: String
     var firstName, lastName: String?
     var professions: [UserProfessions]?
     var avatars: [Avatars]?
     
     static func == (lhs: HomeUser, rhs: HomeUser) -> Bool {
         return lhs.id == rhs.id
     }
 }
 
 //struct Author: Decodable {
 //    let id: Int
 //    let username: String
 //    let firstName: String
 //    let lastName: String
 //}
 */
