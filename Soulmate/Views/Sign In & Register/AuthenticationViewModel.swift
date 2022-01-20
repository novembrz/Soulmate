//
//  AuthenticationViewModel.swift
//  Soulmate
//
//  Created by dasha on 17.01.2022.
//

import Foundation
import SwiftUI


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
        Validators.canSignIn(login: login, password: password) { result in
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
        AuthFetcherServices.signIn(login: login, password: password) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    print("🧀", "string")
                    if let readData = KeychainHelper.standard.read(service: "access-token", account: "soulmate") {
                        if let readAccessToken = String(data: readData, encoding: .utf8) {
                            print("🔑", readAccessToken)
                        }
                    }
                    self.isLoading = false
                    self.isSignInSuccses = true //- for Routing
                    
                case .failure(let authError):
                    self.errorText = authError.errorDescription
                    self.isLoading = false
                    self.isErrorAuth = true
                }
            }
        }
    }
    
    
    //MARK: - Register
    
    private func registerValidation() {
        Validators.canRegister(login: login, email: email, password: password, confirmPassword: confirmPassword) { result in
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
        DispatchQueue.main.async {}
    }
}
