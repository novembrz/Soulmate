//
//  FolderModel.swift
//  Soulmate
//
//  Created by dasha on 29.12.2021.
//

import Foundation


//Папка с работами
struct FolderModel: Decodable {
    var previewPictures: [String] //3 photo for folder preview
    var name: String
    var author: UserModel // future [UserModel] because coathors
}
