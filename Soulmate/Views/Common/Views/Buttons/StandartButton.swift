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
    var action: (() -> ())?
    var routing: Bool = false
    
    
    var body: some View {
        if routing {
            buttonView
        } else {
            actionButton
        }
    }
    
    
    //MARK: - Action Button
    
    var actionButton: some View {
        Button {
            if action != nil {
                action!()
            }
        } label: {
            buttonView
        }
    }
    
    
    //MARK: - Button View
    
    var buttonView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .frame(width: buttonSize, height: buttonSize)
                .foregroundColor(bgColor)
                .buttonShadow()
            
            Image(imageName)
                .resizable()
                .frame(width: imageWidth, height: imageHeight)
                .foregroundColor(iconColor)
                .font(.system(size: imageHeight, weight: .medium))
        }
    }
}
