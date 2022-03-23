//
//  DisplayView.swift
//  Soulmate
//
//  Created by dasha on 10.12.2021.
//

import SwiftUI

struct DisplayView: View {
    
    @State var tokensDoesntMatch: Bool = false
    
    var body: some View {
        Group {
            home
                .fullScreenCover(isPresented: $tokensDoesntMatch) {
                    AuthenticationView(viewModel: AuthenticationViewModel())
                }
        }
        .onAppear() { didRefreshTokensMatch() }
    }
    
    var home: some View {
        GeometryReader { proxy in
            let size = proxy.size
            let bottomEdje = proxy.safeAreaInsets.bottom
            
            DisplayContentView(size: size, bottomEdje: bottomEdje)
                .ignoresSafeArea(.all, edges: .bottom)
        }
    }
    
    
    private func didRefreshTokensMatch() {
        if TokenService.standard.accessToken == nil {
            TokenService.standard.didRefreshTokensMatch { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success:
                        self.tokensDoesntMatch = false
                    case .failure(_):
                        self.tokensDoesntMatch = true
                    }
                }
            }
        } else {
            print("🌈", TokenService.standard.accessToken)
            tokensDoesntMatch = false
        }
    }
    
}


struct HomeContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DisplayView()
                .preferredColorScheme(.light)
            DisplayView()
                .preferredColorScheme(.dark)
        }
    }
}
