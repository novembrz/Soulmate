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
    @Namespace var animation
    
    var size: CGSize
    var bottomEdje: CGFloat
    
    init(size: CGSize, bottomEdje: CGFloat) {
        UITabBar.appearance().isHidden = true
        self.size = size
        self.bottomEdje = bottomEdje
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
                
                Text("Add Content")
                    .tag(AnimateTab.addContent)
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
        }
    }
}

//MARK: - HomeView_Previews

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        DisplayView()
    }
}

