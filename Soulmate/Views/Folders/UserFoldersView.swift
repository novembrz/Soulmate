//
//  UserFoldersView.swift
//  Soulmate
//
//  Created by dasha on 30.11.2021.
//

import SwiftUI

struct UserFoldersView: View {
    
    @ObservedObject var viewModel: UserFoldersViewModel
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack(alignment: .leading, spacing: 34) {
                
                TitleBlock(viewTitle: viewModel.getFolderName()) {
                    moreButtons
                }
                
                switch viewModel.currentViewStyle {
                case .stroke:
                    strokeList
                case .rectangle:
                    rectangleList
                }
            }
            .padding(.bottom, 70)
            .padding(.horizontal, 26)
        }
        .background(Color.defaultBackground.ignoresSafeArea())
    }
    
    
    //MARK: - More Buttons
    
    var moreButtons: some View {
        VStack(alignment: .trailing, spacing: 12) {
            HStack(spacing: 12) {
                StandartButton(imageName: viewModel.currentViewStyle == .stroke ? "rectangles" : "lines", action: viewModel.changeFolderView)
                
                StandartButton(imageName: "more", action: viewModel.openDetailBottomSheet)
            }
            StandartButton(imageName: "user", action: viewModel.routeToUserDescription)
        }
    }
    
    
    //MARK: - List
    
    var strokeList: some View {
        VStack(alignment: .leading, spacing: 17) {
            ForEach($viewModel.professionWorks, id: \.self) { work in
                FolderStrokeCardView(title: work.wrappedValue, description: "Марианна Пелевина", folderImages: viewModel.folderImages, haveProfileButton: false)
            }
        }
    }
    
    var  rectangleList: some View {
        VStack(spacing: 17) {
            ForEach($viewModel.professionWorks, id: \.self) { work in
                FolderRectangleCardView(title: work.wrappedValue, description: "Марианна Пелевина", folderImages: viewModel.folderImages)
            }
        }
    }
}


//MARK: - Previews

struct UserFoldersView_Previews: PreviewProvider {
    static var previews: some View {
        UserFoldersView(viewModel: UserFoldersViewModel())
    }
}
