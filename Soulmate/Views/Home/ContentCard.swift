//
//  ContentCard.swift
//  Soulmate
//
//  Created by dasha on 28.12.2021.
//

import SwiftUI

struct ContentCard: View {
    
    enum ContentType {
        case user, work
    }
    
    var name: String
    var id: Int
    var lastName: String?
    var description: String
    var imageString: String
    var contentType: ContentType
    
    var height: CGFloat = 195
    var minWidth: CGFloat = 82
    var maxWidth: CGFloat = 125
    var isColor: Bool = false
    
    var body: some View {
        CustomNavigationLink {
            ZStack(alignment: .bottomLeading) {
                previewImage
                informationText
            }
        } destination: {
            switch contentType {
            case .user:
                ProfileView(userId: id, viewModel: ProfileViewModel())
            default:
                Text("Error")
            }
        }
    }
    
    
    //MARK: - Preview Image
    
    var previewImage: some View {
        VStack {
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
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: height)
                        .frame(minWidth: minWidth, maxWidth: maxWidth, alignment: .center)
                        .clipped()
                        .cornerRadius(15)
                }
                
            } else {
                RoundedRectangle(cornerRadius: 15)
                    .frame(height: height)
                    .foregroundColor(.mintGreen)
            }
        }
    }
    
    
    //MARK: - Information Text
    
    var informationText: some View {
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
