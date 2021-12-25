//
//  DisplayView.swift
//  Soulmate
//
//  Created by dasha on 10.12.2021.
//

import SwiftUI

struct DisplayView: View {
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            let bottomEdje = proxy.safeAreaInsets.bottom
            
            DisplayContentView(size: size, bottomEdje: bottomEdje)
                .ignoresSafeArea(.all, edges: .bottom)
        }
    }
}


struct HomeContentView_Previews: PreviewProvider {
    static var previews: some View {
        DisplayView()
    }
}
