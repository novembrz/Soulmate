//
//  UserDefaultsProperties.swift
//  Soulmate
//
//  Created by dasha on 26.04.2022.
//

import Foundation


struct UserDefaultsProperties {
    static private var homeViewFilters = [
        CheckboxModel(title: "Люди", filterName: SearchCategory.user.rawValue),
        CheckboxModel(title: "Работы", filterName: SearchCategory.card.rawValue),
        CheckboxModel(title: "Проекты", filterName: SearchCategory.folder.rawValue)
    ]
    
    
    @Storage(key: UserDefaultsKeys.walkthrough.rawValue, defaultValue: false)
    static var walkthroughShown: Bool
    
    @Storage(key: UserDefaultsKeys.walkthrough.rawValue, defaultValue: homeViewFilters)
    static var homeViewChooseFilters: [CheckboxModel]
}


//MARK: - UserDefaultsKeys

enum UserDefaultsKeys: String, Codable {
    case walkthrough = "walkthrough"
    
    case homeViewChooseFilters = "homeViewChooseFilters"
    case homeViewChooseCategories = "homeViewChooseCategories"
    case homeViewChooseProfessions = "homeViewChooseProfessions"
}
