//
//  ProjectCardView.swift
//  Soulmate
//
//  Created by dasha on 03.12.2021.
//

import SwiftUI

struct ProjectStrokeCardView: View {
    
    var title: String
    var description: String
    var coauthorCount: Int?
    var projectImages: [String]?
    var haveProfileButton: Bool
    var mainImage: String { projectImages?[0] ?? "" }
    //var profileId and projectId
    
    @State var showProject = false
    
    var body: some View {
        VStack {
            Button {
                showProject = true
            } label: {
                HStack(spacing: 13) {
                    if projectImages != nil {
                        Image(mainImage)
                        .resizable()
                        .frame(width: 45, height: 45)
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(8)
                    } else {
                        Rectangle()
                            .background(.blue)
                    }
                    
                    VStack(alignment: .leading, spacing: 3) {
                        Text(title)
                            .mediumFont(14)
                            .foregroundColor(.blackText)
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
                        
                        HStack(spacing: 4) {
                            Text(description)
                                .regularFont(11)
                                .foregroundColor(.blackText)
                            
                            if coauthorCount != nil {
                                Text("+ \(coauthorCount ?? 0)")
                                    .regularFont(11)
                                    .foregroundColor(.blackText)
                            }
                        }
                    }
                    
                    Spacer()
                    
                    if haveProfileButton {
                        StandartButton(imageName: "user", bgColor: .mintGreen, iconColor: .whiteToDark, buttonSize: 30, imageWidth: 12, imageHeight: 13) {
                            print("Перешла к юзеру")
                        }
                    } else {
                        Button {
                            // alert
                        } label: {
                            Image("more")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.blackText)
                                .padding(.trailing, 6)
                        }
                    }
                }
                .padding(10)
                .background(Color.whiteToDark)
                .cornerRadius(15)
                .frame(maxWidth: .infinity)
                .shadow(color: .elementShadow.opacity(0.3), radius: 30, x: 4, y: 4)
            }
        }
        .fullScreenCover(isPresented: $showProject) {
            UserWorksView(viewModel: UserWorksViewModel())
        }
    }
}

struct ProjectCard_Previews: PreviewProvider {
    static var previews: some View {
      // HomeView(viewModel: HomeViewModel())
        UserProjectsView(viewModel: UserProjectsViewModel())
    }
}
