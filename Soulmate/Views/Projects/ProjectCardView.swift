//
//  ProjectCardView.swift
//  Soulmate
//
//  Created by dasha on 03.12.2021.
//

import SwiftUI

struct ProjectCardView: View {
    
    var userImage: String
    var title: String
    var description: String
    var haveProfileButton: Bool
    
    var body: some View {
        VStack {
            Button {
                print("Перешла к проекту")
            } label: {
                HStack(spacing: 13) {
                    Image(userImage)
                        .resizable()
                        .frame(width: 45, height: 45)
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(8)
                    
                    VStack(alignment: .leading) {
                        Text(title)
                            .mediumFont(14)
                            .foregroundColor(.blackText)
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
                        
                        Text(description)
                            .regularFont(11)
                            .foregroundColor(.blackText)
                    }
                    
                    Spacer()
                    
                    if haveProfileButton {
                        StandartButton(imageName: "user", bgColor: .mintGreen, iconColor: .whiteToDark, buttonSize: 30, imageWidth: 12, imageHeight: 13) {
                            print("Перешла к юзеру")
                        }
                    } else {
                        Button {} label: {
                            Image("more")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.blackText)
                                .padding(.trailing, 6)
                        }
                    }
                }
                .padding(10)
                .background(Color.whiteToDark)
                .cornerRadius(15)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 26)
                
            }
           // .frame(minWidth: .infinity)
        }
    }
}

struct ProjectCard_Previews: PreviewProvider {
    static var previews: some View {
      // HomeView(viewModel: HomeViewModel())
        UserProjectsView(viewModel: UserProjectsViewModel())
    }
}
