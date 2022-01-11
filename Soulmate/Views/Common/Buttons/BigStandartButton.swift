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
            
            Image(imageName)
                .resizable()
                .frame(width: width, height: height)
                .foregroundColor(.blackToWhite)
        }
    }
}

struct BigStandartButton_Previews: PreviewProvider {
    static var previews: some View {
        BigStandartButton(imageName: "more")
            .background(Color.defaultBackground)
    }
}
