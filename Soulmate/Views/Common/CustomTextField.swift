//
//  CustomTextField.swift
//  Soulmate
//
//  Created by dasha on 17.01.2022.
//

import SwiftUI

struct CustomTextField: View {
    
    @Binding var field: String
    var icon: String
    var placeholder: String
    var isPassword: Bool = false
    
    @State private var passwordVisibility = false
    //@State var searchText: String = ""
    
    var text: (() -> ())?
    
    
    var body: some View {
        HStack {
            HStack {
                HStack {
                    if isPassword {
                        if passwordVisibility {
                            textField
                        } else {
                            secureField
                        }
                    } else {
                        textField
                    }
                }
                .overlay(
                    buttons
                )
                .transition(.move(edge: .trailing))
                .animation(.easeOut, value: 0.5)
            }
        }
    }
    
    
    //MARK: - Text Field
    
    var textField: some View {
        TextField(placeholder.lowercased(), text: $field)
            .frame(height: 47)
            .padding(.leading, 40)
            .disableAutocorrection(true)
            .mediumFont(12)
            .foregroundColor(.blackText)
            .background(Color.whiteToDark)
            .accentColor(.mintGreen)
            .cornerRadius(15)
            .elementShadow()
    }
    
    
    //MARK: - Secure Field
    
    var secureField: some View {
        SecureField(placeholder.lowercased(), text: $field)
            .frame(height: 47)
            .padding(.leading, 40)
            .disableAutocorrection(true)
            .mediumFont(12)
            .foregroundColor(.blackText)
            .background(Color.whiteToDark)
            .accentColor(.mintGreen)
            .cornerRadius(15)
            .elementShadow()
    }
    
    
    //MARK: - Buttons
    
    var buttons: some View {
        HStack {
            Image(icon)
                .resizable()
                .scaledToFit()
                .frame(height: 11)
                .foregroundColor(.placeholder)
            
           
            if isPassword { eyeButton } else { xmarkButton }
        }
        .padding(.horizontal, 12)
        .foregroundColor(.darkForElements)
    }
    
    
    //MARK: - Xmark Button
    
    var xmarkButton: some View {
        HStack {
            Spacer()
            
            if field != "" {
                Button {
                    field = ""
                } label: {
                    Image(systemName: "xmark.circle")
                        .padding(.vertical)
                        .foregroundColor(.placeholder)
                }
            }
        }
    }
    
    
    //MARK: - Eye Button
    
    var eyeButton: some View {
        HStack {
            Spacer()
            
            if field != "" {
                Button {
                    passwordVisibility.toggle()
                } label: {
                    Image(passwordVisibility ? "eye-off" : "eye-on")
                        .padding(.vertical)
                        .foregroundColor(.placeholder)
                }
            }
        }
    }
}


//MARK: - Previews

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
       AuthenticationView(viewModel: AuthenticationViewModel())
    }
}
