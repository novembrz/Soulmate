//
//  DataFetcherServices.swift
//  Soulmate
//
//  Created by dasha on 29.12.2021.
//

import Foundation
import SwiftUI

struct DataFetcherServices {
    
    static var homePageURL = "http://localhost:8080/api/home"
    static var userURL = "http://localhost:8080/api/user"
    
    
    static func fetchHomePage(completion: @escaping (HomeModel?) -> Void) {
        NetworkService.fetchData(urlString: homePageURL, completion: completion)
    }
    
    
    static func fetchUser(id: Int, completion: @escaping (UserModel?) -> Void) {
        let urlString = userURL + "/\(id)"
        NetworkService.fetchData(urlString: urlString, completion: completion)
    }
}
