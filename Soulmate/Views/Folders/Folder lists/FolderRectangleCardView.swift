//
//  FolderRectangleCardView.swift
//  Soulmate
//
//  Created by dasha on 23.12.2021.
//

import SwiftUI

struct FolderRectangleCardView: View {
    var folder: FolderModel
    //    private var author: String { if coauthorCount != nil : "\(folder.author) + \(folder.coauthor.count)" ? "\(folder.author)"}
    private var description: String { "\(folder.name)" }
    private var author: String { "\(folder.author.firstName ?? "") \(folder.author.lastName ?? "")" }
    var folderImagesCount: Int { folder.previewPictures?.count ?? 0 }
    
    var body: some View {
        VStack(spacing: 9) {
            previewImages
            folderDescription
        }
    }
    
    
    //MARK: - Preview Images
    
    var previewImages: some View {
        HStack(spacing: 2) {
            if folder.previewPictures != nil, folder.previewPictures != [] {
                if let urlString = URL(string: folder.previewPictures?[0] ?? "") {
                    AsyncImage(url: urlString) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .scaledToFill()

                    if folderImagesCount > 1 {
                        VStack(spacing: 2) {
                            secondImage
                            thirdImage
                        }
                    }
                }
            } else {
                Image(Constants.plugImage)
                    .resizable()
                    .scaledToFill()
            }
        }
        .frame(height: 170)
        .frame(width: UIScreen.width - Constants.horizontalInset*2)
        .clipped()
        .cornerRadius(15)
    }
    
    
    //MARK: - Second Image
    
    var secondImage: some View {
        Group {
            if let urlString = URL(string: folder.previewPictures?[1] ?? "") {
                AsyncImage(url: urlString) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .scaledToFill()
                .frame(width: 100)
                .frame(height: folderImagesCount > 2 ? 85 : 170)
                .clipped()
            }
        }
    }
    
    
    //MARK: - Third Image
    
    var thirdImage: some View {
        Group {
            if folderImagesCount > 2,
               let urlString = URL(string: folder.previewPictures?[2] ?? "") {
                AsyncImage(url: urlString) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .scaledToFill()
                .frame(width: 100)
                .frame(height: 85)
                .clipped()
            }
        }
    }
    
    
    //MARK: - Project Description
    
    var folderDescription: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 3) {
                Text(description)
                    .boldFont(16)
                    .foregroundColor(.blackText)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                
                Text(author)
                    .regularFont(11)
                    .foregroundColor(.blackText)
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)
            }
            
            Spacer()
            
            Button {
                // alert
            } label: {
                Image("more")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 15, height: 15)
                    .foregroundColor(.blackText)
                    .padding(.trailing, 6)
            }
        }
    }
}


//MARK: - Previews

struct FolderRectangleCardView_Previews: PreviewProvider {
    static var previews: some View {
        FoldersView(viewModel: FoldersViewModel())
    }
}
