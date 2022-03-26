//
//  InternetConnectionView.swift
//  Soulmate
//
//  Created by dasha on 26.03.2022.
//

import SwiftUI
import Lottie

struct InternetConnectionView: View {
    
    var body: some View {
        VStack(spacing: 60) {
            Image("lostServerPlug")
                .resizable()
                .scaledToFit()
            
            Button {
                // Обновить
            } label: {
                LongButton(title: "Попробовать снова", isGradient: true)
            }
        }
    }
}

struct InternetConnectionView_Previews: PreviewProvider {
    static var previews: some View {
        InternetConnectionView()
    }
}
