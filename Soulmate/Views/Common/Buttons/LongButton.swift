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
    var action: (() -> ())
    
    var body: some View {
        VStack {
            Button {
                action()
            } label: {
                HStack(spacing: 11) {
                    if iconName != nil {
                        Image(iconName!)
                    }
                    
                    Text(title)
                        .mediumFont(14)
                        .foregroundColor(.whiteText)
                }
                .padding(.vertical, 15)
                .frame(maxWidth: .infinity)
            }
            .background(Color.mintGreen)
            .cornerRadius(15)
        }
        .padding(.horizontal, 26)
    }
}

struct LongButton_Previews: PreviewProvider {
    static var previews: some View {
        LongButton(title: "Найти на карте", iconName: "map") {
            print("")
        }
    }
}
