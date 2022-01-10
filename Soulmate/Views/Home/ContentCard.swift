//
//  ContentCard.swift
//  Soulmate
//
//  Created by dasha on 28.12.2021.
//

import SwiftUI

struct ContentCard: View {
    
    var name: String
    var lastName: String?
    var description: String
    var imageString: String
    
    var height: CGFloat = 195
    var isColor: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            if !isColor {
                Image(imageString) // распарсить 
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
                Text("\(name)\n\(lastName ?? "")")
                    .boldFont(12)
                    .foregroundColor(.whiteText)
                    .multilineTextAlignment(.leading)
                
                Text(description)
                    .regularFont(11)
                    .foregroundColor(.whiteText)
            }
            .padding(10)
        }
    }
}
//
//struct ContentCard_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentCard(content: "Azizova")
//    }
//}
