//
//  AuthenticationViewModel.swift
//  Soulmate
//
//  Created by dasha on 17.01.2022.
//

import Foundation


final class AuthenticationViewModel: ObservableObject {
    
    enum AuthenticationType {
        case register, signIn
    }
    
    @Published var authenticationType: AuthenticationType = .signIn
    @Published var selected = false
    
    @Published var login: String?
    @Published var email: String?
    @Published var password: String?
    @Published var confirmPassword: String?
    
    
    var descriptionText: String { authenticationType == .signIn ? "Нет аккаунта?" : "Уже есть аккаунт?" }
    var switchButtonText: String { authenticationType == .signIn ? "Зарегестрироваться" : "Войти" }
    var authButtonText: String { authenticationType == .signIn ? "Войти" : "Продолжить" }
    
    func authentication() {
        switch authenticationType {
        case .register:
            
        case .signIn:
            
            signIn(username: login, password: password)
        }
    }
    
    
    
    private func signIn(username: String, password: String) {
        AuthService.postData(param: ["username": username, "password": password]) { result in
            switch result {
            case .success(let string):
                
                print("🧀", string)
            case .failure(let error):
                print(error.localizedDescription)
                // покажи опвещение об ошибке
            }
        }
    }
    

}
