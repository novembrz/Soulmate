//
//  TitleBlock.swift
//  Soulmate
//
//  Created by dasha on 10.12.2021.
//

import SwiftUI

struct TitleBlock<Content: View>: View {
    
    private var viewTitle: String = ""
    private var titleColor: Color? = .blackText
    private var padding: CGFloat? = 11 //34
    private let content: Content?
    
    
    public init(viewTitle: String, titleColor: Color? = .blackText, padding: CGFloat? = 11, @ViewBuilder content: () -> Content) {
        self.viewTitle = viewTitle
        self.titleColor = titleColor
        self.padding = padding
        self.content = content()
    }
    
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: padding) {
            HStack {
                Spacer()
                content
            }
            
            Text(viewTitle)
                .boldFont(24)
                .foregroundColor(titleColor)
                .frame(maxWidth: 260, alignment: .leading)
        }
    }
}


struct TitleBlock_Previews: PreviewProvider {
    static var previews: some View {
        TitleBlock(viewTitle: "Искать") {
            Button {} label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: 43, height: 43)
                        .foregroundColor(.whiteToDark)
                    
                    Image("more")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
            }
        }
        .padding(.horizontal, 26)
        .background(Color.defaultBackground)
    }
}
