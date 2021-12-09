//
//  ContentBlock.swift
//  Soulmate
//
//  Created by dasha on 03.12.2021.
//

import SwiftUI

struct ContentBlock<Content: View>: View {
    
    private var title: String?
    private var titleFontSize: CGFloat = 20
    private var buttonTitle: String?
    private var buttonFontSize: CGFloat = 17
    private var bottomPadding: CGFloat = 48
    private var onButtonTap: (() -> ())?
    private let content: Content
    
    
    //MARK: - Initialize
    
    //полный инит
    public init(title: String, titleFontSize: CGFloat = 21, buttonTitle: String, buttonFontSize: CGFloat = 18, onButtonTap: @escaping () -> (), @ViewBuilder content: () -> Content) {
        self.title = title
        self.titleFontSize = titleFontSize
        self.buttonTitle = buttonTitle
        self.buttonFontSize = buttonFontSize
        self.onButtonTap = onButtonTap
        self.content = content()
    }
    
    //инит c тайтлом
    public init(title: String, titleFontSize: CGFloat = 21, @ViewBuilder content: () -> Content) {
        self.title = title
        self.titleFontSize = titleFontSize
        self.content = content()
    }
    
    //инит с кнопкой
    public init(buttonTitle: String, buttonFontSize: CGFloat = 18, onButtonTap: @escaping () -> (), @ViewBuilder content: () -> Content) {
        self.buttonTitle = buttonTitle
        self.buttonFontSize = buttonFontSize
        self.onButtonTap = onButtonTap
        self.content = content()
    }
    
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    //MARK: - View
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            if buttonTitle != nil || title != nil {
                HStack {
                    if let title = title {
                        Text(title)
                            .boldFont(titleFontSize)
                            .foregroundColor(.blackText)
                    }
                    Spacer()
                    if let title = buttonTitle {
                        Button(action: {
                            onButtonTap?()
                        }) {
                            Text(title)
                                .foregroundColor(.mintGreen)
                                .boldFont(buttonFontSize)
                        }
                    }
                }
                .padding(.horizontal, 26)
            }
            
            self.content
        }
        
    }
}


//MARK: - Previews

struct ContentBlock_Previews: PreviewProvider {
    static var previews: some View {
        ContentBlock(title: "Search", buttonTitle: "All") {
            print("")
        } content: {
            SearchView(viewModel: SearchViewModel())
        }
    }
}
