//
//  FolderStrokeCardView.swift
//  Soulmate
//
//  Created by dasha on 03.12.2021.
//

import SwiftUI

struct FolderStrokeCardView: View {
    
    var folder: FolderModel
    var haveProfileButton: Bool

    //    private var description: String { if coauthorCount != nil : "\(folder.author) + \(folder.coauthor.count)" ? "\(folder.author)"}
    private var description: String { "\(folder.author.lastName) \(folder.author.firstName)" }
    private var mainImage: String? { folder.previewPictures == [] ? nil : folder.previewPictures?[0] }


    var body: some View {
        CustomNavigationLink {
            content
        } destination: {
            UserWorksView(viewModel: UserWorksViewModel())
        }
    }
    
    
    //MARK: - content
    
    var content: some View {
        HStack(spacing: 13) {
            image
            folderTextInformation
            
            Spacer()
            
            folderButton
        }
        .padding(10)
        .background(Color.whiteToDark)
        .cornerRadius(15)
        .frame(maxWidth: .infinity)
        .elementShadow()
    }
    
    
    //MARK: - image
    
    var image: some View {
        VStack {
            if folder.previewPictures != nil, let urlString = URL(string: mainImage ?? "") {
                AsyncImage(url: urlString) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 45, height: 45)
                .aspectRatio(contentMode: .fit)
                .cornerRadius(8)
                
            } else {
                Image(Constants.plugImage)
                    .resizable()
                    .frame(width: 45, height: 45)
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(8)
            }
        }
    }
    
    
    //MARK: - folder Text Information
    
    var folderTextInformation: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(folder.name)
                .mediumFont(14)
                .foregroundColor(.blackText)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
            
            Text(description)
                .regularFont(11)
                .foregroundColor(.blackText)
        }
    }
    
    
    //MARK: - folder Button
    
    var folderButton: some View {
        VStack {
            if haveProfileButton {
                CustomNavigationLink {
                    StandartButton(imageName: "user", bgColor: .mintGreen, iconColor: .whiteToDark, buttonSize: 30, imageWidth: 12, imageHeight: 13, routing: true)
                } destination: {
                    ProfileView(userId: folder.author.id, viewModel: ProfileViewModel())
                }
            } else {
                CustomNavigationLink {
                    Image("more")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.blackText)
                        .padding(.trailing, 6)
                } destination: {
                   
                }
            }
        }
    }
}


//MARK: - Previews

struct FolderCard_Previews: PreviewProvider {
    static var previews: some View {
        FoldersView(viewModel: FoldersViewModel())
    }
}
