//
//  FolderRectangleCardView.swift
//  Soulmate
//
//  Created by dasha on 23.12.2021.
//

import SwiftUI

struct FolderRectangleCardView: View {
    var title: String
    var description: String
    var coauthorCount: Int?
    var folderImages: [String]?
    var folderImagesCount: Int { folderImages?.count ?? 0 }
    
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
            if folderImages != nil {
                if let image = folderImages?[0] {
                    Image(image)
                        .resizable()
                        .scaledToFill()
                }
                
                VStack(spacing: 2) {
                    if folderImagesCount > 1 {
                        Image(folderImages?[1] ?? "")
                            .resizable()
                            .frame(width: 100)
                            .frame(height: folderImagesCount > 2 ? 85 : .infinity)
                    }
                    
                    if folderImagesCount > 2 {
                        Image(folderImages?[2] ?? "")
                            .resizable()
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
                Text(title)
                    .boldFont(14)
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
