//
//  DataFetcherServices.swift
//  Soulmate
//
//  Created by dasha on 29.12.2021.
//

import Foundation
import SwiftUI

struct DataFetcherServices {
    
    static func fetchHomePage(completion: @escaping (Result, HomeModel?) -> Void) {
        NetworkService.fetchData(urlString: ServiceUrl.homePageURL, completion: completion)
    }
    
    static func fetchSearchingData(searchingText: String, searchCategories: [SearchCategory] = [.user, .profession, .card, .folder], completion: @escaping (Result, HomeModel?) -> Void) {
        let categories = searchCategories.map { $0.rawValue }
        NetworkService.postData(param: ["sorting": ["pageNumber": 0,
                                                    "pageSize": 10,
                                                    "sortDirection": "ASC",
                                                    "sortBy": "id"],
                                        "text": searchingText,
                                        "searchTypes": categories],
                                urlString: ServiceUrl.search,
                                completion: completion)
    }
    
    static func fetchUser(id: Int, completion: @escaping (Result, UserModel?) -> Void) {
        let urlString = ServiceUrl.userURL.withId(id)
        NetworkService.fetchData(urlString: urlString, completion: completion)
    }
    
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
