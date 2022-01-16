//
//  FoldersView.swift
//  Soulmate
//
//  Created by dasha on 30.11.2021.
//

import SwiftUI

struct FoldersView: View {
    
    @ObservedObject var viewModel: FoldersViewModel
    @State var userProfessionId: Int?
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            content
            moreButtons
        }
        .background(Color.defaultBackground.ignoresSafeArea())
        .onAppear {
            viewModel.fetchData(userProfessionId: userProfessionId)
        }
    }
    
    
    //MARK: - Content
    
    var content: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 34) {
                
                TitleBlock(viewTitle: viewModel.getFolderName())
                
                if viewModel.folders != [] {
                    switch viewModel.currentViewStyle {
                    case .stroke:
                        //rectangleList
                        strokeList
                    case .rectangle:
                        rectangleList
                    }
                } else {
                    Image("folderPlug")
                        .resizable()
                        .scaledToFit()
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
            ForEach(viewModel.folders, id: \.self) { folder in 
                FolderStrokeCardView(folder: folder, haveProfileButton: false)
            }
        }
    }
    
    var  rectangleList: some View {
        VStack(spacing: 17) {
            ForEach(viewModel.folders, id: \.self) { folder in
                FolderRectangleCardView(folder: folder)
            }
        }
    }
}


//MARK: - Previews

struct FoldersView_Previews: PreviewProvider {
    static var previews: some View {
        FoldersView(viewModel: FoldersViewModel())
    }
}
