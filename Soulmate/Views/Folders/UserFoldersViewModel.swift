//
//  UserFoldersViewModel.swift
//  Soulmate
//
//  Created by dasha on 10.12.2021.
//

import SwiftUI

final class UserFoldersViewModel: ObservableObject {
    
    enum ViewStyle {
        case stroke, rectangle
    }
    
    @Published var professionWorks = ["Концепция феминистического сериала по «1984» Дж. Оруэлла", "Сценарий сериала «Гамбит»", "Фильм «Отверженные»", "Чек-лист «Как создать реалистичного отрицательного персонажа, которому все будут сопережевать»", "Сценарий сериала «Код 13»"]
    
    @Published var currentViewStyle: ViewStyle = .stroke
    @Published var folderImages = ["Azizova", "Dilan", "Kasigina"]
    
    func getFolderName() -> String {
        return "Сценарист"
    }
    
    func routeToUserDescription() {
        print(#function)
    }
    
    func openDetailBottomSheet() {
        print(#function)
    }
    
    func changeFolderView() {
        currentViewStyle = currentViewStyle == .stroke ? .rectangle : .stroke
    }
}

