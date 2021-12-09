//
//  BackButton.swift
//  Soulmate
//
//  Created by dasha on 27.11.2021.
//

import SwiftUI

struct BackButton: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Button {
            withAnimation {
                presentationMode.wrappedValue.dismiss()
            }
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .frame(width: 43, height: 43)
                    .foregroundColor(.whiteToDark)
                
                Image(systemName: "chevron.left")
                    .foregroundColor(.blackToWhite)
                    .font(.system(size: 14, weight: .bold))
            }
        }
    }
}

struct BackButton_Previews: PreviewProvider {
    static var previews: some View {
        BackButton()
            .background(Color.defaultBackground)
    }
}
