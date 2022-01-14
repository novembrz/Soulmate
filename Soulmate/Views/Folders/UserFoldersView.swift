//
//  UserFoldersView.swift
//  Soulmate
//
//  Created by dasha on 30.11.2021.
//

import SwiftUI

struct UserFoldersView: View {
    
    @ObservedObject var viewModel: UserFoldersViewModel
    //@State var folders: [FolderModel] //отдаем сразу папки, название как вытащить
    //@State var professionId: [FolderModel] // чтобы распарсить данные и вытащить все папки из профессии
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            content
            moreButtons
        }
        .background(Color.defaultBackground.ignoresSafeArea())
    }
    
    
    //MARK: - Content
    
    var content: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 34) {
                
                TitleBlock(viewTitle: viewModel.getFolderName())
                
                if viewModel.professionWorks != [] {
                    switch viewModel.currentViewStyle {
                    case .stroke:
                        strokeList
                    case .rectangle:
                        rectangleList
                    }
                } else {
                    Image("folderPlug")
                }
            }
            .padding(.top, Constants.topInset)
            .padding(.bottom, Constants.bottomInset)
            .padding(.horizontal, Constants.horizontalInset)
        }
    }
    
    
    //MARK: - More Buttons
    
    var moreButtons: some View {
        HStack(alignment: .top, spacing: 12) {
            Spacer()
            
            StandartButton(imageName: viewModel.currentViewStyle == .stroke ? "rectangles" : "lines", action: viewModel.changeFolderView)
            
            VStack(spacing: 12) {
                StandartButton(imageName: "more", action: viewModel.openDetailBottomSheet)
                
                StandartButton(imageName: "user", action: viewModel.routeToUserDescription)
            }
        }
        .padding(.top, Constants.topInset)
        .padding(.horizontal, Constants.horizontalInset)
    }
    
    
    //MARK: - List
    
    var strokeList: some View {
        VStack(alignment: .leading, spacing: 17) {
            ForEach(viewModel.professionWorks, id: \.self) { folder in //MARK: замени массив
                FolderStrokeCardView(folder: folder, haveProfileButton: false)
            }
        }
    }
    
    var  rectangleList: some View {
        VStack(spacing: 17) {
            ForEach(viewModel.professionWorks, id: \.self) { folder in
                FolderRectangleCardView(folder: folder)
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
