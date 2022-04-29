//
//  DataFetcherServices.swift
//  Soulmate
//
//  Created by dasha on 29.12.2021.
//

import Foundation
import SwiftUI

struct DataFetcherServices {
    // folders
    
    static func fetchAllFolders(completion: @escaping (Result, [FolderModel]?) -> Void) {
        NetworkService.fetchData(urlString: ServiceUrl.Folder.base, completion: completion)
    }
    
    static func fetchUserProfessionFolders(id: Int, completion: @escaping (Result, FoldersDataModel?) -> Void) {
        let urlString = ServiceUrl.Folder.userProfession.withId(id)
        NetworkService.fetchData(urlString: urlString, completion: completion)
    }
    
    static func fetchFolder(id: Int, completion: @escaping (Result, FoldersDataModel?) -> Void) {
        let urlString = ServiceUrl.Folder.base.withId(id) 
        NetworkService.fetchData(urlString: urlString, completion: completion)
    }
    
    // user works
    
    static func fetchUserWorkPlaces(id: Int, completion: @escaping (Result, [WorkPlacesModel]?) -> Void) {
        let urlString = ServiceUrl.WorkPlace.byUser.withId(id) 
        NetworkService.fetchData(urlString: urlString, completion: completion)
    }
}


enum SearchCategory: String {
    case user = "USER"
    case profession = "PROFESSION"
    case card = "CARD"
    case folder = "FOLDER"
}
