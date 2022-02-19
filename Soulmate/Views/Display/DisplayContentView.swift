//
//  DisplayContentView.swift
//  Soulmate
//
//  Created by dasha on 10.12.2021.
//

import SwiftUI

//MARK: - AnimateTab

enum AnimateTab: String, CaseIterable {
    case home = "home"
    case search = "eye"
    case addContent = "circlePlus"
    case profile = "smile"
    case message = "message"
}


//MARK: - DisplayContentView

struct DisplayContentView: View {
    @State var currentTab: AnimateTab = .home
    @State var contentType: ContentType
    @State var bottomSheetShown = false
    @State var isOpenUploadContent = false
    
    @Namespace var animation
    
    var size: CGSize
    var bottomEdje: CGFloat
    
    init(size: CGSize, bottomEdje: CGFloat) {
        UITabBar.appearance().isHidden = true
        self.size = size
        self.bottomEdje = bottomEdje
        contentType = .music
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $currentTab) {
                HomeView(viewModel: HomeViewModel())
                    .tag(AnimateTab.home)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.white)
                
                Text("Search")
                    .tag(AnimateTab.search)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.white)
                
                ProfileView(userId: 2, authorizedUserProfile: true, viewModel: ProfileViewModel())
                    .tag(AnimateTab.profile)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.white)
                
                Text("Message")
                    .tag(AnimateTab.message)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.white)
            }
            
            CustomTabBar(viewModel: TabBarViewModel(size: size, bottomEdje: bottomEdje, animation: animation), currentTab: $currentTab)
            
            bottomSheetAction
        }
    }
    
    
    //MARK: - BottomSheet Action
    
    var bottomSheetAction: some View {
        Group {
            BottomSheetView(
                isOpen: $bottomSheetShown,
                maxHeight: 389) {
                    SelectContentView(title: "Опубликовать") { contentType in
                        self.contentType = contentType
                        self.bottomSheetShown.toggle()
                        self.isOpenUploadContent.toggle()
                    }
                }
            
            Button {
                bottomSheetShown.toggle()
            } label: {
                Rectangle()
                    .frame(width: 70, height: 65)
                    .padding(.bottom, 10)
                    .foregroundColor(.clear)
            }
            
        }.sheet(isPresented: $isOpenUploadContent) {
            UploadContentView(contentType: $contentType)
        }
    }
}


//MARK: - HomeView_Previews

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        DisplayView()
    }
}

