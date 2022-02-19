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
                    self.successAuth()
                case .failure(let authError):
                    self.failureAuth(authError)
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
        isLoading = true
        print("🐝", password)
        AuthFetcherServices.register(login: login, email: email, password: password) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    let credentials = Credentials(username: self.login, password: self.password)
                    KeychainService.standard.save(credentials, account: credentials.username)
                    self.successAuth()
                case .failure(let authError):
                    self.failureAuth(authError)
                }
            }
        }
    }
    
    
    //MARK: - Auth Result
    
    private func successAuth() {
        if let readData = KeychainService.standard.read(account: "access-token", type: AuthToken.self) {
            print("🔑", readData)
        }
        
        self.isLoading = false
        self.isSignInSuccses = true //- for Routing
    }
    
    private func failureAuth(_ authError: AuthError) {
        self.errorText = authError.errorDescription
        self.isLoading = false
        self.isErrorAuth = true
    }
    
    
    //MARK: - Biometric
    
    //НАДО ЛИ
//    func getBiometricType() -> String {
//        let context = LAContext()
//        _ = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
//
//        switch context.biometryType {
//        case .faceID:
//            return "faceid"
//        case .touchID:
//            return "lock"
//        case .none:
//            return "lock"
//        @unknown default:
//            return "lock"
//        }
//    }
//
//    func tryBiometricAuthentication() {
//        let context = LAContext() //получаете доступ к биометрической аутентификации
//        var error: NSError?
//
//        //проверяете, доступна ли аутентификация
//        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
//            let reason = "Authenticate to unlock your note." //причина
//            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { authenticated, error in
//
//                DispatchQueue.main.async {
//                    if authenticated {
//                        self.isSignInSuccses = true //авторизировались, иди дальше
//                    } else {
//                        if let errorString = error?.localizedDescription {
//                            print("Error in biometric policy evaluation: \(errorString)")
//                        }
//                        //MARK: ERROR
//                    }
//                }
//            }
//        } else { //вообще аутенфикация не доступна
//            if let errorString = error?.localizedDescription {
//                print("Error in biometric policy evaluation: \(errorString)")
//            }
//            //MARK: ERROR
//        }
//    }
}
