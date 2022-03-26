//
//  ServiceUrl.swift
//  Soulmate
//
//  Created by dasha on 17.02.2022.
//

import Foundation

final class ServiceUrl {
    static var host = "https://soulmade.herokuapp.com/api"
    static var userURL = host + "/user"
    static var professionURL = host + "/profession"
    static var homePageURL = host + "/home"
    static var whoIAmURL = host + "/whoiam"
    
    
    final class Auth {
        static private var base = host + "/auth"
        static var signIn = base + "/signin"
        static var register = base + "/signup"
        static var refreshToken = base + "/refreshtoken"
        static var isFreeData = base + "/is-free"
    }
    
    final class Folder {
        static var base = host + "/folders"
        static var userProfession = base + "/user-profession"
    }
    
    final class WorkPlace {
        static private var base = host + "/was-work"
        static var byUser = base + "/by-user"
    }
}
