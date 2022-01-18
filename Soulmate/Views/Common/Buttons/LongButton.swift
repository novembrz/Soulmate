//
//  LongButton.swift
//  Soulmate
//
//  Created by dasha on 03.12.2021.
//

import SwiftUI

struct LongButton: View {
    
    var title: String
    var iconName: String?
    var rigthIcon: String?
    var isGradient = false
    
    var body: some View {
        ZStack {
            backgrounView
            
            HStack(spacing: 11) {
                if iconName != nil {
                    Image(iconName!)
                        .foregroundColor(.whiteText)
                }
                
                Text(title)
                    .mediumFont(14)
                    .foregroundColor(.whiteText)
            }
            .padding(.vertical, 15)
            
            HStack {
                Spacer()
                Image(rigthIcon != nil ? rigthIcon! : "")
                    .foregroundColor(.whiteText)
                    .padding(.trailing, Constants.horizontalInset)
            }
        }
        .frame(width: .infinity, height: 47)
    }
    
    
    //MARK: - backgrounView
    
    var backgrounView: some View {
        Group {
            if isGradient {
                LinearGradient(colors: [.lightPurple, .turquoise], startPoint: .leading, endPoint: .trailing)
                    .cornerRadius(15)
            } else {
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(.mintGreen)
            }
        }
    }
}


//MARK: - Previews

struct LongButton_Previews: PreviewProvider {
    static var previews: some View {
        LongButton(title: "Найти на карте", iconName: "map", rigthIcon: "rigth")
    }
}
