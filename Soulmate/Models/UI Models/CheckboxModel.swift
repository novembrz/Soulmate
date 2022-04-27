//
//  CheckboxModel.swift
//  Soulmate
//
//  Created by dasha on 27.04.2022.
//

import Foundation


struct CheckboxModel: Decodable, Encodable {
    var title: String
    var filterName: String
    var isChoose: Bool = false
}



//MARK: - Extension

extension CheckboxModel: Hashable {
    static func == (lhs: CheckboxModel, rhs: CheckboxModel) -> Bool {
        return lhs.title == rhs.title
    }
}
