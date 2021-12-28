//
//  ContentCard.swift
//  Soulmate
//
//  Created by dasha on 28.12.2021.
//

import SwiftUI

struct ContentCard: View {
    
    var content: String
    var height: CGFloat = 195
    var isColor: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            if !isColor {
                Image(content)
                    .resizable()
                    .frame(height: height)
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(15)
            } else {
                RoundedRectangle(cornerRadius: 15)
                    .frame(height: height)
                    .foregroundColor(.mintGreen)
            }
            
            VStack(alignment: .leading) {
                Text("Sasha\n\(content)")
                    .boldFont(12)
                    .foregroundColor(.whiteText)
                    .multilineTextAlignment(.leading)
                
                Text("Writter")
                    .regularFont(11)
                    .foregroundColor(.whiteText)
            }
            .padding(10)
        }
    }
}

struct ContentCard_Previews: PreviewProvider {
    static var previews: some View {
        ContentCard(content: "Azizova")
    }
}
