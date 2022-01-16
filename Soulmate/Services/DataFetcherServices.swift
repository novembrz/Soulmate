//
//  DataFetcherServices.swift
//  Soulmate
//
//  Created by dasha on 29.12.2021.
//

import Foundation
import SwiftUI

struct DataFetcherServices {
    
    static var homePageURL = "http://192.168.1.66:8082/api/home"
    static var userURL = "http://192.168.1.66:8082/api/user"
    static var professionURL = "http://192.168.1.66:8082/api/profession"
    static var foldersURL = "http://192.168.1.66:8082/api/folders"
    static var workPlacesURL = "http://localhost:8082/api/was-work"
    
    static func fetchHomePage(completion: @escaping (HomeModel?) -> Void) {
        NetworkService.fetchData(urlString: homePageURL, completion: completion)
    }
    
    static func fetchUser(id: Int, completion: @escaping (UserModel?) -> Void) {
        let urlString = userURL + "/\(id)"
        NetworkService.fetchData(urlString: urlString, completion: completion)
    }
    
    
    // folders
    
    static func fetchFolders(completion: @escaping ([FolderModel]?) -> Void) {
        NetworkService.fetchData(urlString: foldersURL, completion: completion)
    }
    
    static func fetchUserProfessionFolders(id: Int, completion: @escaping (FoldersDataModel?) -> Void) {
        let urlString = foldersURL + "/user-profession/\(id)"
        NetworkService.fetchData(urlString: urlString, completion: completion)
    }
    
    
    // user works
    
    static func fetchUserWorkPlaces(id: Int, completion: @escaping ([WorkPlacesModel]?) -> Void) {
        let urlString = workPlacesURL + "/by-user/\(id)"
        NetworkService.fetchData(urlString: urlString, completion: completion)
    }
}


/*
 folders
 folders/user-profession/id - сюда передаем айди карточки профессии (userProfessionId ), именно ай ди связи - чтобы получить папки данной карточки юзера
 folders/id
 */
