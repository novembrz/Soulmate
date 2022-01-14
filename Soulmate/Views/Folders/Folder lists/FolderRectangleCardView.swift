//
//  FolderRectangleCardView.swift
//  Soulmate
//
//  Created by dasha on 23.12.2021.
//

import SwiftUI

struct FolderRectangleCardView: View {
    var folder: FolderModel
    //    private var description: String { if coauthorCount != nil : "\(folder.author) + \(folder.coauthor.count)" ? "\(folder.author)"}
    private var description: String { "\(folder.author.lastName) \(folder.author.firstName)" }
    var folderImagesCount: Int { folder.previewPictures?.count ?? 0 }
    
    var body: some View {
        CustomNavigationLink {
            VStack(spacing: 9) {
                previewImages
                folderDescription
            }
        } destination: {
            UserWorksView(viewModel: UserWorksViewModel())
        }
    }
    
    
    //MARK: - Preview Images
    
    var previewImages: some View {
        HStack(spacing: 2) {
            if folder.previewPictures != nil,
                let urlString = URL(string: folder.previewPictures?[0] ?? "") {
                AsyncImage(url: urlString) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .scaledToFill()
                
                
                VStack(spacing: 2) {
                    if folderImagesCount > 1,
                       let urlString = URL(string: folder.previewPictures?[1] ?? "") {
                        AsyncImage(url: urlString) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 100)
                        .frame(height: folderImagesCount > 2 ? 85 : .infinity)
                    }
                    
                    if folderImagesCount > 2,
                       let urlString = URL(string: folder.previewPictures?[2] ?? "") {
                        AsyncImage(url: urlString) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 100)
                        .frame(height: 85)
                    }
                }
                
            } else {
                Image(Constants.plugImage)
            }
        }
        .frame(height: 170)
        .cornerRadius(15)
    }

    
    //MARK: - Project Description

    var folderDescription: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 3) {
                Text(description)
                    .boldFont(14)
                    .foregroundColor(.blackText)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
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
        UserFoldersView(viewModel: UserFoldersViewModel())
    }
}
