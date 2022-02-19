//
//  AuthenticationView.swift
//  Soulmate
//
//  Created by dasha on 17.01.2022.
//

import SwiftUI

struct AuthenticationView: View {

    @ObservedObject var viewModel: AuthenticationViewModel
    
    var body: some View {
        VStack {
            VStack(spacing: 53) {
                VStack(spacing: 71) {
                    Image("soulmate")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 130)
                    
                    switch viewModel.authenticationType {
                    case .register:
                        register
                    case .signIn:
                        signIn
                    }
                }
                authButton
            }
            Spacer()
            
            switchViewButton
        }
        .padding(.top, 98)
        .padding(.horizontal, Constants.horizontalInset)
        .padding(.bottom, Constants.bottomInset)
        .background(Color.defaultBackground)
        .showBanner(isShowing: $viewModel.forgotPassword, message: viewModel.forgorPasswordMessage, notificationType: .message)
        .showBanner(isShowing: $viewModel.isErrorAuth, message: viewModel.errorText ?? "", notificationType: .error)
    }
    
    
    //MARK: - Sign In
    
    var signIn: some View {
        VStack(alignment: .trailing, spacing: 14) {
            CustomTextField(field: $viewModel.login,icon: "userLight", placeholder: "Логин")
            CustomTextField(field: $viewModel.password,icon: "key", placeholder: "Пароль", isPassword: true)
            
            Button {
                viewModel.forgotPassword = true
            } label: {
                Text("забыли пароль?")
                    .mediumFont(14)
                    .foregroundColor(.blackText)
            }
        }
    }
    
    
    //MARK: - Register
    
    var register: some View {
        VStack(spacing: 12) {
            CustomTextField(field: $viewModel.login,icon: "userLight", placeholder: "Логин")
            CustomTextField(field: $viewModel.email,icon: "mail", placeholder: "Почта")
                .keyboardType(.emailAddress)
            CustomTextField(field: $viewModel.password,icon: "key", placeholder: "Пароль", isPassword: true)
            CustomTextField(field: $viewModel.confirmPassword,icon: "key", placeholder: "Повторите пароль", isPassword: true)
        }
    }
    
    
    //MARK: - Auth button
    
    var authButton: some View {
        Button {
            viewModel.authentication()
        } label: {
            LongButton(title: viewModel.authButtonText, rigthIcon: "rigth", isGradient: true)
        }
        .modifier(ShakeEffect(shakes: viewModel.isErrorAuth ? 2 : 0))
        .animation(.goodRipple(), value: viewModel.isErrorAuth)
    }
    
    
    //MARK: - Switch View Button
    
    var switchViewButton: some View {
        VStack(spacing: 4) {
            Text(viewModel.descriptionText)
                .regularFont(16)
                .foregroundColor(.placeholder)
            
            Button {
                withAnimation {
                    viewModel.authenticationType = viewModel.authenticationType == .signIn ? .register : .signIn
                }
            } label: {
                Text(viewModel.switchButtonText)
                    .regularFont(17)
                    .foregroundColor(.blackText)
            }
        }
    }
}


//MARK: - Previews

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView(viewModel: AuthenticationViewModel())
    }
}
