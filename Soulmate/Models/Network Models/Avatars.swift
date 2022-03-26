//
//  Avatars.swift
//  Soulmate
//
//  Created by dasha on 23.03.2022.
//

import Foundation


struct Avatars: Decodable {
    var link: String?
    var main: Bool?
}


extension Avatars: Hashable {
    static func == (lhs: Avatars, rhs: Avatars) -> Bool {
        return lhs.link == rhs.link
    }
}
