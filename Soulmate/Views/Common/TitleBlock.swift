//
//  TitleBlock.swift
//  Soulmate
//
//  Created by dasha on 11.01.2022.
//

import SwiftUI

struct TitleBlock: View {
    
    private var viewTitle: String = ""
    private var subTitle: String? = ""
    private var titleColor: Color? = .blackText
    
    
    public init(viewTitle: String, subTitle: String? = "", titleColor: Color? = .blackText) {
        self.viewTitle = viewTitle
        self.subTitle = subTitle
        self.titleColor = titleColor
    }
    
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
        .padding(.top, 77)
    }
}
