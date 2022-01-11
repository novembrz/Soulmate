//
//  BigTextBlock.swift
//  Soulmate
//
//  Created by dasha on 10.01.2022.
//

import SwiftUI

struct BigTextBlock: View {
    
    var text: String
    @State var readMore = false
    @State var textLineLimit = 3
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(text)
                .mediumFont(14)
                .foregroundColor(.blackText)
                .multilineTextAlignment(.leading)
                .lineLimit(readMore ? nil : textLineLimit)
                .lineSpacing(10)
            
            HStack {
                Spacer()
                
                if !readMore {
                    Button {
                        readMore = true
                    } label: {
                        Text("читать дальше...")
                            .boldFont(16)
                            .foregroundColor(.mintGreen)
                    }
                }
            }
        }
    }
}
