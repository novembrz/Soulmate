//
//  AuthenticationView.swift
//  Soulmate
//
//  Created by dasha on 17.01.2022.
//

import SwiftUI

struct AuthenticationView: View {
    var body: some View {
        VStack {
            Image("soulmate")
                .resizable()
                .scaledToFit()
                .frame(width: 130)
                
                
        }
        .padding(.top, 98)
        .padding(.horizontal, Constants.horizontalInset)
        .background(Color.defaultBackground)
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
    }
}
