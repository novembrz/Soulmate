//
//  FolderModel.swift
//  Soulmate
//
//  Created by dasha on 29.12.2021.
//

import Foundation


//Папка с работами
struct FolderModel: Decodable {
    var previewPictures: [String]? //3 photo for folder preview
    var name: String
    var author: UserModel // future [UserModel] because coathors
}


extension FolderModel: Hashable {
    static func == (lhs: FolderModel, rhs: FolderModel) -> Bool {
        return lhs.name == rhs.name
        && lhs.author == rhs.author
    }
}
