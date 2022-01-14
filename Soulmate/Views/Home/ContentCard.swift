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
    var minWidth: CGFloat = 82
    var maxWidth: CGFloat = 125
    var isColor: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            if !isColor {
                if let urlString = URL(string: imageString) {
                    AsyncImage(url: urlString) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .aspectRatio(contentMode: .fill)
                    .frame(height: height)
                    .frame(minWidth: minWidth, maxWidth: maxWidth, alignment: .center)
                    .clipped()
                    .cornerRadius(15)
                } else {
                    Image(Constants.plugImage)
                }
                
            } else {
                RoundedRectangle(cornerRadius: 15)
                    .frame(height: height)
                    .foregroundColor(.mintGreen)
            }
            
            VStack(alignment: .leading) {
                Text("\(name)")
                    .boldFont(12)
                    .foregroundColor(.whiteText)
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)
                
                Text("\(lastName ?? "")")
                    .boldFont(12)
                    .foregroundColor(.whiteText)
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)
                
                Text(description)
                    .regularFont(11)
                    .foregroundColor(.whiteText)
                    .lineLimit(1)
            }
            .padding(10)
        }
    }
}
