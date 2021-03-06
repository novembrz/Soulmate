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
            if viewModel.isInternetConnected {
                content
                moreButtons
            } else {
                InternetConnectionView()
            }
        }
        .background(Color.defaultBackground.ignoresSafeArea())
        .onAppear {
            viewModel.fetchData(userProfessionId: userProfessionId)
        }
        .onChange(of: viewModel.refreshing) { newValue in
            viewModel.fetchData(userProfessionId: userProfessionId, type: .refreshing)
        }
    }
    
    
    //MARK: - Content
    
    var content: some View {
        RefreshableScrollView(refreshing: $viewModel.refreshing) {
            VStack(alignment: .leading, spacing: 34) {
                TitleBlock(viewTitle: viewModel.getFolderName())
                if viewModel.folders != [] {
                    contentList
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
            StandartButton(imageName: "more", action: viewModel.openDetailBottomSheet)
        }
        .padding(.top, Constants.topInset)
        .padding(.horizontal, Constants.horizontalInset)
    }
    
    
    //MARK: - List
    
    var contentList: some View {
        VStack(alignment: .leading, spacing: 17) {
            ForEach(viewModel.folders, id: \.self) { folder in
                CustomNavigationLink {
                    if viewModel.folders != [] {
                        switch viewModel.currentViewStyle {
                        case .stroke:
                            FolderStrokeCardView(folder: folder, haveProfileButton: false)
                        case .rectangle:
                            FolderRectangleCardView(folder: folder)
                        }
                    } else {
                        Image("folderPlug")
                            .resizable()
                            .scaledToFit()
                    }
                } destination: {
                    UserWorksView(folderId: folder.id, viewModel: UserWorksViewModel())
                }
            }
        }
    }
}


//MARK: - Previews

struct FoldersView_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavigationView {
            FoldersView(viewModel: FoldersViewModel())
        }
        .preferredColorScheme(.dark)
    }
}
