//
//  CustomTextField.swift
//  Soulmate
//
//  Created by dasha on 17.01.2022.
//

import SwiftUI

struct CustomTextField: View {
    
    var icon: String
    var placeholder: String
    
    var body: some View {
        HStack {
            Image(icon)
                .resizable()
                .scaledToFit()
                .frame(height: 11)
            
            
        }
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(icon: "key", placeholder: "Пароль")
    }
}
