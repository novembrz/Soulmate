//
//  TabButton.swift
//  Soulmate
//
//  Created by dasha on 10.12.2021.
//

import SwiftUI
//MARK: - TabButton

struct TabButton: View {
    
    @Binding var currentTab: AnimateTab
    
    var tab: AnimateTab
    var animation: Namespace.ID
    var onTab: (AnimateTab) -> ()
    
    var body: some View {
        Image(tab.rawValue)
            .foregroundColor(currentTab == tab ? .white : .blackText)
            .frame(width: 45, height: 45)
            .background(
                ZStack {
                    if currentTab == tab {
                        Circle()
                            .fill(Color.mintGreen)
                            .matchedGeometryEffect(id: "Tab", in: animation)
                    }
                }
            )
            .frame(maxWidth: .infinity)
            .contentShape(Rectangle())
            .onTapGesture {
                if currentTab != tab {
                    onTab(tab)
                }
            }
    }
}


//MARK: - NavigationCircle

struct NavigationCircle: View {
    @ObservedObject var viewModel: TabBarViewModel
    var width: CGFloat
    
    var body: some View {
        Circle()
            .fill(Color.defaultBackground)
            .frame(width: 45, height: 45)
            .scaleEffect(viewModel.bottomEdje == 0 ? 0.8 : 1)
            .offset(x: width, y: viewModel.offset.height)
    }
}


//MARK: - AnimateTabBar_Previews

struct TabButton_Previews: PreviewProvider {
    static var previews: some View {
        DisplayView()
    }
}

