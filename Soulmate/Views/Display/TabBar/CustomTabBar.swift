//
//  CustomTabBar.swift
//  Soulmate
//
//  Created by dasha on 10.12.2021.
//

import SwiftUI

struct CustomTabBar: View {
    @ObservedObject var viewModel: TabBarViewModel
    @Binding var currentTab: AnimateTab
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(AnimateTab.allCases, id: \.rawValue) { tab in
                TabButton(currentTab: $currentTab, tab: tab, animation: viewModel.animation) { pressedTab in
                    
                    //navigationAnimation
                    withAnimation(.navigationAnimation()) {
                        viewModel.startAnimation = true
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                        withAnimation(.navigationAnimation()) {
                            currentTab = pressedTab
                        }
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.45) {
                        withAnimation(.navigationAnimation()) {
                            viewModel.startAnimation = false
                        }
                    }
                }
            }
        }
        .background(
            animatedCircle
            ,alignment: .leading
        )
        .padding(.horizontal)
        .padding(.top, 7)
        .padding(.bottom, viewModel.bottomEdje == 0 ? 23 : viewModel.bottomEdje)
        .background(
            Rectangle()
                .fill(Color.defaultBackground)
                .shadow(color: .black.opacity(0.045), radius: 5, x: 0, y: -5)
        )
    }
    
    
    //MARK: - animatedCircle
    
    var animatedCircle: some View {
        ZStack {
            Rectangle()
                .fill(Color.mintGreen)
                .frame(width: 45, height: 45)
                .offset(y: 40)
            
            NavigationCircle(viewModel: viewModel, width: viewModel.offset.width)
            NavigationCircle(viewModel: viewModel, width: -viewModel.offset.width)
        }
        .offset(x: viewModel.getStartOffset())
        .offset(x: viewModel.getOffset(currentTab: currentTab))
    }
}


//MARK: - AnimateTabBar_Previews

struct AnimateTabBar_Previews: PreviewProvider {
    static var previews: some View {
        DisplayView()
    }
}
