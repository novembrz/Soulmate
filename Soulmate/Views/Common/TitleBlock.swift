//
//  TitleBlock.swift
//  Soulmate
//
//  Created by dasha on 10.12.2021.
//

import SwiftUI

struct TitleBlock<Content: View>: View {
    
    private var viewTitle: String = ""
    private let content: Content
    
    public init(viewTitle: String, @ViewBuilder content: () -> Content) {
        self.viewTitle = viewTitle
        self.content = content()
    }
    
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    public var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 34) {
                BackButton()
                
                Text(viewTitle)
                    .boldFont(24)
                    .foregroundColor(.blackText)
            }
            .padding(.top, 26)
            
            Spacer()
            
            content
        }
    }
}

struct TitleBlock_Previews: PreviewProvider {
    static var previews: some View {
        TitleBlock(viewTitle: "Искать") {
            Text("d")
        }
            .background(Color.defaultBackground)
    }
}
