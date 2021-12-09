//
//  StandartButton.swift
//  Soulmate
//
//  Created by dasha on 29.11.2021.
//

import SwiftUI

struct StandartButton: View {
    
    var imageName: String
    var bgColor: Color = .whiteToDark
    var iconColor: Color = .blackToWhite
    var buttonSize: CGFloat = 32
    var imageWidth: CGFloat = 15
    var imageHeight: CGFloat = 15
    var action: (() -> ())
    
    var body: some View {
        Button {
          action()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .frame(width: buttonSize, height: buttonSize)
                    .foregroundColor(bgColor)
                
                Image(imageName)
                    .resizable()
                    
                    .frame(width: imageWidth, height: imageHeight)
                    .foregroundColor(iconColor)
                    .font(.system(size: imageHeight, weight: .medium))
            }
        }
    }
}
