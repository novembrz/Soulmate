//
//  WalkthroughModel.swift
//  Soulmate
//
//  Created by dasha on 21.12.2021.
//

import SwiftUI

struct Walkthrough: Identifiable {
    var id = UUID().uuidString
    var title: String
    var colorTitle: String
    var description: String
    var secondTitle: String?
    var secondColorTitle: String?
    var secondDescription: String?
    var accentColor: Color
}

var walkthrough: [Walkthrough] = [
    Walkthrough(title: "добро пожаловать в", colorTitle: "soulmate", description: "сообщество творческих людей, которые хотят быть замеченными", accentColor: .lightPurple),
    Walkthrough(title: "делитесь", colorTitle: "творчеством", description: "Делитесь своими тексами, музыкой, фотографиями и полноценными  проектами!", secondTitle: "тренируйте", secondColorTitle: "насмотренность", secondDescription: "для этого просто просматривайте, сохраняйте и оценивайте понравившиеся работы!", accentColor: .turquoise),
    Walkthrough(title: "найдите свое", colorTitle: "комьюнити", description: "объединяйтесь и находите близкий по духу людей для работы и совместного творчества", accentColor: .lightPurple)
]
