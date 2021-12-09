//
//  ProjectCardView.swift
//  Soulmate
//
//  Created by dasha on 03.12.2021.
//

import SwiftUI

struct ProjectCardView: View {
    
    var user: String
    
    var body: some View {
        Button {
            print("Перешла к проекту")
        } label: {
            HStack(spacing: 13) {
                Image(user)
                    .resizable()
                    .frame(width: 45, height: 45)
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(8)
                
                VStack(alignment: .leading) {
                    Text("Загородные дома")
                        .mediumFont(14)
                        .foregroundColor(.blackText)
                    
                    Text("Дизайн инерьера")
                        .regularFont(11)
                        .foregroundColor(.blackText)
                }
                
                Spacer()
                
                StandartButton(imageName: "user", bgColor: .mintGreen, iconColor: .whiteToDark, buttonSize: 30, imageWidth: 12, imageHeight: 13) {
                    print("Перешла к юзеру")
                }
            }
            .padding(10)
            .background(Color.whiteToDark)
            .cornerRadius(15)
            .frame(width: 310)
            .padding(.horizontal, 26)
        }
    }
}

struct ProjectCard_Previews: PreviewProvider {
    static var previews: some View {
       MainView(viewModel: MainViewModel())
    }
}
