//
//  TitleBlock.swift
//  Soulmate
//
//  Created by dasha on 10.12.2021.
//

import SwiftUI

struct TitleBlock<Content: View>: View {
    
    private var viewTitle: String = ""
    private let content: Content?
    
    public init(viewTitle: String, @ViewBuilder content: () -> Content) {
        self.viewTitle = viewTitle
        self.content = content()
    }
    
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    public var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 34) {
                BackButton()
                
                Text(viewTitle)
                    .boldFont(24)
                    .foregroundColor(.blackText)
            }
            
            Spacer()
            
            content
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
