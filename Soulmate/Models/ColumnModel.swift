//
//  ColumnModel.swift
//  Soulmate
//
//  Created by dasha on 27.11.2021.
//

import SwiftUI


struct ColumnModel: Identifiable, Equatable {
    var id = UUID()
    var gridItems = [UserProfessions]()
    
    static func == (lhs: ColumnModel, rhs: ColumnModel) -> Bool {
        return lhs.id == rhs.id
    }
}
