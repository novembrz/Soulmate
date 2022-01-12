//
//  HomeModel.swift
//  Soulmate
//
//  Created by dasha on 29.12.2021.
//

import Foundation


struct HomeModel: Decodable {
    var users: [UserModel] //exelent
   // var cards: [WorkCardModel]?
    var folders: [FolderModel]
}
