//
//  UserWorksViewModel.swift
//  Soulmate
//
//  Created by dasha on 24.12.2021.
//

import SwiftUI


final class UserWorksViewModel: ObservableObject {
    @Published var readMore = false
    @Published var works: [String]? = ["Kasigina", "ignatenko","Petrov", "Dilan", "Azizova", "novembrz", "yar"]
    @Published var folderNames = "Загородный дом Ивановых"
    @Published var author = "Kasigina"
    @Published var coauthors: [String]? = ["Dilan", "Azizova"]
    @Published var folderDescription = "Загородный дом в стиле хай-тек, общей площадью 109 м². Террасы и балконы: 67,84 м². Габариты: 14.06x8.36 м. Гостиная, столовая и частично закрытая кухня образуют единое помещение, которое визуально расширено за счёт террасы. Дневная зона выглядит более просторно чем в проекте Zx41 за счет отсутствия стенной перегородки между кухней и столовой. Уюта добавляет камин, устроенный у внутренней стены. Рядом с гаражом спланировано большое хозяйственное помещение. В данном варианте изменено расположение лестницы на второй этаж."
    
    var columns: [GridItem] = Array(repeating: .init(.flexible(minimum: 155, maximum: 160), spacing: 16, alignment: .top), count: 2)
}
