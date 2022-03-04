//
//  AuthenticationViewModel.swift
//  Soulmate
//
//  Created by dasha on 17.01.2022.
//

import Foundation
import SwiftUI
import LocalAuthentication


final class AuthenticationViewModel: ObservableObject {
    
    enum AuthenticationType {
        case register, signIn
    }
    
    @Published var login: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var authenticationType: AuthenticationType = .signIn
    
    @Published var isLoading = false
    @Published var isSignInSuccses = false
    @Published var isRegisterSuccses = false
    @Published var isErrorAuth = false
    @Published var errorText: String?
    
    @Published var forgotPassword = false
    
    var descriptionText: String { authenticationType == .signIn ? "Нет аккаунта?" : "Уже есть аккаунт?" }
    var switchButtonText: String { authenticationType == .signIn ? "Зарегестрироваться" : "Войти" }
    var authButtonText: String { authenticationType == .signIn ? "Войти" : "Продолжить" }
    var forgorPasswordMessage = "На Вашу почту выслана ссылка для сброса пароля!"

    
    //MARK: - Auth
    
    func authentication() {
        switch authenticationType {
        case .register:
            registerValidation()
        case .signIn:
            signInValidation()
        }
    }
    
    
    //MARK: - SignIn
    
    private func signInValidation() {
        AuthValidators.canSignIn(login: login, password: password) { result in
            switch result {
            case .success:
                self.signIn()
            case .failure(let authError):
                self.errorText = authError.errorDescription
                self.isErrorAuth = true
            }
        }
    }
    
    private func signIn() {
        isLoading = true
        AuthFetcherServices.signIn(login: login, password: password) { result, authToken in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    guard let token = authToken else { return }
                    print("🥦", token)
                    KeychainService.standard.save(AuthToken(accessToken: token.accessToken, refreshToken: token.refreshToken), account: "token")
                    self.isLoading = false
                    self.isSignInSuccses = true
                case .failure(let authError):
                    self.failureAuth(authError)
                }
            }
        }
    }
    
    
    //MARK: - Register
    
    private func registerValidation() {
        AuthValidators.canRegister(login: login, email: email, password: password, confirmPassword: confirmPassword) { result in
            switch result {
            case .success:
                self.register()
            case .failure(let authError):
                self.errorText = authError.errorDescription
                self.isErrorAuth = true
            }
        }
    }
    
    private func register() {
        isLoading = true
        print("🐝", password)
        AuthFetcherServices.register(login: login, email: email, password: password) { result, _ in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    let credentials = Credentials(username: self.login, password: self.password)
                    KeychainService.standard.save(credentials, account: credentials.username)
                    self.isLoading = false
                    self.isRegisterSuccses = true
                case .failure(let authError):
                    self.failureAuth(authError)
                }
            }
        }
    }
    
    
    //MARK: - Auth Result
    
    private func failureAuth(_ authError: AuthError) {
        self.errorText = authError.errorDescription
        self.isLoading = false
        self.isErrorAuth = true
    }
    
}
