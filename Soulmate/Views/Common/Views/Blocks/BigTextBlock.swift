//
//  BigTextBlock.swift
//  Soulmate
//
//  Created by dasha on 26.03.2022.
//

import SwiftUI


struct BigTextBlock: View {
    
    @State private var expanded: Bool = false
    @State private var truncated: Bool = false
    
    private var text: String
    var lineLimit = 3
    
    
    init(_ text: String, lineLimit: Int = 3) {
        self.text = text
        self.lineLimit = lineLimit
    }
    
    var body: some View {
        someText
            .mediumFont(14)
            .foregroundColor(.blackText)
            .multilineTextAlignment(.leading)
            .lineSpacing(7)
        
    }
    
    
    //MARK: - someText
    
    var someText: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(text)
                .lineLimit(expanded ? nil : lineLimit)
                .background(
                    Text(text)
                        .lineLimit(lineLimit)
                        .background(
                            GeometryReader { displayedGeometry in
                                ZStack {
                                    Text(self.text)
                                        .background(GeometryReader { fullGeometry in
                                            Color.clear.onAppear {
                                                self.truncated = fullGeometry.size.height > displayedGeometry.size.height
                                            }
                                        })
                                }
                                .frame(height: .greatestFiniteMagnitude)
                            })
                        .hidden()
                )
            
            if truncated {
                HStack {
                    Spacer()
                    toggleButton
                }
            }
        }
    }
    
    
    //MARK: - toggleButton
    
    var toggleButton: some View {
        Button {
            self.expanded.toggle()
        } label: {
            Text(self.expanded ? "скрыть текст" : "читать дальше...")
                .boldFont(16)
                .foregroundColor(.mintGreen)
        }
    }
}


//MARK: - Preview

struct BigTextBlock_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            BigTextBlock("aaaaaaa aaa")
            
            BigTextBlock("Загородный дом в стиле хай-тек, общей площадью 109 м². Террасы и балконы: 67,84 м². Габариты: 14.06x8.36 м. Гостиная, столовая и частично закрытая кухня образуют единое помещение, которое визуально расширено за счёт террасы. Дневная зона выглядит более просторно чем в проекте Zx41 за счет отсутствия стенной перегородки между кухней и столовой. Уюта добавляет камин, устроенный у внутренней стены. Рядом с гаражом спланировано большое хозяйственное помещение. В данном варианте изменено расположение лестницы на второй этаж.")
        }
    }
}
