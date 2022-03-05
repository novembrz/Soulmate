//
//  LoadingViewModifier.swift
//  Soulmate
//
//  Created by dasha on 05.03.2022.
//

import SwiftUI


struct LoadingViewModifier: ViewModifier {
    @Binding var isShowing: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            if isShowing {
                ZStack {
                    //            Color.black.opacity(0.1)
                    //                .ignoresSafeArea(.all)
                    LottieView(filename: "loadingLottie", isLooping: true)
                        .frame(width: 200, height: 200)
                }
            }
        }
    }
}


//MARK: - View Extension

extension View {
    func showLoading(isShowing: Binding<Bool>) -> some View {
        modifier(LoadingViewModifier(isShowing: isShowing))
    }
}
