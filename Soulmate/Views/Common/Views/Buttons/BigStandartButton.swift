//
//  BigStandartButton.swift
//  Soulmate
//
//  Created by dasha on 11.01.2022.
//

import SwiftUI

struct BigStandartButton: View {
    
    var imageName: String
    var width: CGFloat? = 20
    var height: CGFloat? = 20
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .frame(width: 43, height: 43)
                .foregroundColor(.whiteToDark)
                .buttonShadow(radius: 30)
            
            Image(imageName)
                .resizable()
                .frame(width: width, height: height)
                .foregroundColor(.blackToWhite)
        }
    }
}
