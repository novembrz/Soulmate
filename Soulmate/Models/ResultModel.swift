//
//  ResultModel.swift
//  Soulmate
//
//  Created by dasha on 17.02.2022.
//

import Foundation

//enum Result {
//    case success 
//    case failure(AuthError)
//}

enum Result {
    case success
    case failure(LocalizedError)
}


struct isFree: Decodable {
    var success: Bool
}
