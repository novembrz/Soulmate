//
//  ContentBlock.swift
//  Soulmate
//
//  Created by dasha on 03.12.2021.
//

import SwiftUI

struct ContentBlock<Content: View, Destination: View>: View {
    
    private var title: String?
    private let titleFontSize: CGFloat = 20
    private var buttonTitle: String?
    private var buttonFontSize: CGFloat = 17
    private var bottomPadding: CGFloat = 48
    private let content: Content
    private var destination: Destination?
    
    
    //MARK: - Initialize
    
    //полный инит
    public init(title: String, buttonTitle: String, @ViewBuilder content: () -> Content, @ViewBuilder destination: () -> Destination?) {
        self.title = title
        self.buttonTitle = buttonTitle
        self.destination = destination()
        self.content = content()
    }
    
    //инит c тайтлом без кнопки
    public init(title: String, @ViewBuilder content: () -> Content, @ViewBuilder destination: () -> Destination?) {
        self.title = title
        self.content = content()
        self.destination = destination()
    }
    
    //инит с кнопкой без тайтла
    public init(buttonTitle: String, @ViewBuilder content: () -> Content, @ViewBuilder destination: () -> Destination) {
        self.buttonTitle = buttonTitle
        self.destination = destination()
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
                        CustomNavigationLink {
                            Text(title)
                                .foregroundColor(.mintGreen)
                                .boldFont(buttonFontSize)
                        } destination: {
                            destination
                        }
                    }
                }
                .padding(.horizontal, Constants.horizontalInset)
            }
            self.content
        }
    }
}


//MARK: - Previews

struct ContentBlock_Previews: PreviewProvider {
    static var previews: some View {
        ContentBlock(title: "Search", buttonTitle: "All") {
            ProfileView(userId: 2, viewModel: ProfileViewModel())
        } destination: {
            SearchView(viewModel: SearchViewModel())
        }
    }
}
