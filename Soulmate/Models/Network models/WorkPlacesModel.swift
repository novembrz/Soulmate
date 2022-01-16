//
//  WorkPlacesModel.swift
//  Soulmate
//
//  Created by dasha on 16.01.2022.
//

import Foundation


struct WorkPlacesModel: Decodable {
    var id: Int
    var name: String
    var startDate: String
    var endDate: String?
    var picture: String?
}

extension WorkPlacesModel: Hashable {
    static func == (lhs: WorkPlacesModel, rhs: WorkPlacesModel) -> Bool {
        return lhs.id == rhs.id
    }
}
