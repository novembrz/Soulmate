//
//  CardModel.swift
//  Soulmate
//
//  Created by dasha on 23.03.2022.
//

import SwiftUI

struct CardModel: Decodable {
    let id: Int
    let description: String
    let name: String
    let author: UserModel
    let contentLink: String?
    let picture: String?
}

extension CardModel: Hashable {
    static func == (lhs: CardModel, rhs: CardModel) -> Bool {
        return lhs.id == rhs.id
    }
}
