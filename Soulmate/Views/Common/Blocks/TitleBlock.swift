//
//  TitleBlock.swift
//  Soulmate
//
//  Created by dasha on 11.01.2022.
//

import SwiftUI

struct TitleBlock: View {
    
    var viewTitle: String = ""
    var subTitle: String? = ""
    var titleColor: Color? = .blackText
    var topPadding: CGFloat? = 77
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(viewTitle)
                .boldFont(24)
                .foregroundColor(titleColor)
                .frame(maxWidth: 260, alignment: .leading)
            
            if subTitle != "" {
                Text(subTitle ?? "")
                    .mediumFont(18)
                    .foregroundColor(titleColor)
                    .frame(maxWidth: 260, alignment: .leading)
            }
        }
        .frame(maxWidth: 260, alignment: .leading)
        .padding(.top, topPadding)
    }
}
