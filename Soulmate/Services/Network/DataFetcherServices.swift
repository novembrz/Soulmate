//
//  DataFetcherServices.swift
//  Soulmate
//
//  Created by dasha on 29.12.2021.
//

import Foundation

struct DataFetcherServices {
    
    static func fetchHomePage(completion: @escaping (HomeModel?) -> Void) {
        NetworkService.fetchData(urlString: ServiceUrl.homePageURL, completion: completion)
    }
    
    static func fetchUser(id: Int, completion: @escaping (UserModel?) -> Void) {
        let urlString = ServiceUrl.userURL.withId(id)
        NetworkService.fetchData(urlString: urlString, completion: completion)
    }
    
    // folders
    
    static func fetchAllFolders(completion: @escaping ([FolderModel]?) -> Void) {
        NetworkService.fetchData(urlString: ServiceUrl.Folder.base, completion: completion)
    }
    
    static func fetchUserProfessionFolders(id: Int, completion: @escaping (FoldersDataModel?) -> Void) {
        let urlString = ServiceUrl.Folder.userProfession.withId(id)
        NetworkService.fetchData(urlString: urlString, completion: completion)
    }
    
    static func fetchFolder(id: Int, completion: @escaping (FoldersDataModel?) -> Void) {
        let urlString = ServiceUrl.Folder.base.withId(id) 
        NetworkService.fetchData(urlString: urlString, completion: completion)
    }
    
    // user works
    
    static func fetchUserWorkPlaces(id: Int, completion: @escaping ([WorkPlacesModel]?) -> Void) {
        let urlString = ServiceUrl.WorkPlace.byUser.withId(id) 
        NetworkService.fetchData(urlString: urlString, completion: completion)
    }
}


/*
 folders
 folders/user-profession/id - сюда передаем айди карточки профессии (userProfessionId ), именно ай ди связи - чтобы получить папки данной карточки юзера
 folders/id
 */
