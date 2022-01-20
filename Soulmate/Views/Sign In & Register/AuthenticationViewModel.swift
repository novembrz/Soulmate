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
    
    @Published var authenticationType: AuthenticationType = .signIn
    @Published var isErrorAuth = false
    @Published var errorText: String?
    @Published var isSignInSuccses = false
    
    @Published var login: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    
    
    var descriptionText: String { authenticationType == .signIn ? "Нет аккаунта?" : "Уже есть аккаунт?" }
    var switchButtonText: String { authenticationType == .signIn ? "Зарегестрироваться" : "Войти" }
    var authButtonText: String { authenticationType == .signIn ? "Войти" : "Продолжить" }
    
    func authentication() {
        switch authenticationType {
        case .register:
            register()
        case .signIn:
            signInValidation()
        }
    }
    
    
    //MARK: - SignIn
    
    private func signInValidation() {
        //is Loading = true
        Validators.canRegister(login: login, email: email, password: password, confirmPassword: confirmPassword) { result in
            switch result {
            case .success:
                self.signIn()
            case .failure(let authError):
                self.errorText = authError.errorDescription
                self.isErrorAuth = true
                //is Loading = false
            }
        }
    }
    
    
    private func signIn() {
        AuthFetcherServices.signIn(login: login, password: password) { result in
            switch result {
            case .success:
                print("🧀", "string")
                if let readData = KeychainHelper.standard.read(service: "access-token", account: "soulmate") {
                    if let readAccessToken = String(data: readData, encoding: .utf8) {
                        print("🔑", readAccessToken)
                    }
                }
                //is Loading = false
                self.isSignInSuccses = true //- for Routing
                
            case .failure(let authError):
                self.errorText = authError.errorDescription
                self.isErrorAuth = true
                //is Loading = false
            }
        }
    }
    
    
    
    //MARK: - Register
    
    private func register() {
        Validators.canRegister(login: login, email: email, password: password, confirmPassword: confirmPassword) { _ in
            
        }
    }
}
