//
//  ProfileBaseInfoView.swift
//  Soulmate
//
//  Created by dasha on 08.12.2021.
//

import SwiftUI

struct ProfileBaseInfoView: View {
    var icon: String
    var number: Int
    
    var body: some View {
        HStack(spacing: 10) {
            Image(icon)
                .resizable()
                .foregroundColor(.whiteToDark)
                .scaledToFit()
                .frame(height: 11)
                .textShadow()
            
            Text("\(number)")
                .foregroundColor(.whiteText)
                .mediumFont(14)
                .textShadow()
        }
    }
}
