//
//  Validators.swift
//  Soulmate
//
//  Created by dasha on 18.01.2022.
//

import Foundation
import SwiftUI


class Validators {
    
    static func canRegister(login: String, email: String, password: String, confirmPassword: String, completion: @escaping (Result) -> Void) {
        guard isRegisterFilled(login: login, email: email, password: password, confirmPassword: confirmPassword) else { return completion(.failure(AuthError.notFilled)) }
        guard password == confirmPassword else { return completion(.failure(AuthError.notEqualPasswords)) }
        guard isDifficultPassword(password) else { return completion(.failure(AuthError.easyPassword)) }
        guard isSimpleEmail(email) else { return completion(.failure(AuthError.invalidEmail)) }
        guard freeEmail(email) else { return completion(.failure(AuthError.registeredEmail)) }
        guard freeLogin(login) else { return completion(.failure(AuthError.registeredLogin)) }
        completion(.success)
    }
    
    
    //MARK: - isFilled - можно ли в олну функцию
    
    static private func isProfileDataFilled(firstName: String?, lastName: String?, profession: [UserProfessions]?) -> Bool {
        guard !(firstName ?? "").isEmpty,
              !(lastName ?? "").isEmpty,
              !(profession ?? []).isEmpty else { return false }
        return true
    }
    
    static func isSignInFilled(login: String, password: String) -> Bool {
        guard !login.isEmpty,
              !password.isEmpty
        else { return false }
        return true
    }
    
    static private func isRegisterFilled(login: String, email: String, password: String, confirmPassword: String) -> Bool {
        guard !login.isEmpty,
              !email.isEmpty,
              !password.isEmpty,
              !confirmPassword.isEmpty else { return false }
        return true
    }
    
    
    //MARK: - Email
    
    static private func isSimpleEmail(_ email: String) -> Bool {
        let emailRegEx = "^.+@.+\\..{2,}$"
        return check(text: email, regEx: emailRegEx)
    }
    
    static private func check(text: String, regEx: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regEx)
        return predicate.evaluate(with: text)
    }
    
    
    //MARK: - Free data
    
    static private func freeLogin(_ login: String) -> Bool {
        // Яр скажет свободен ли такой на бэке
        return true
    }
    
    static private func freeEmail(_ email: String) -> Bool {
        // Яр скажет свободен ли такой на бэке
        return true
    }
    
    static private func isDifficultPassword(_ password: String) -> Bool {
        return true
    }
    
    static private func isSuccessName(name: String, lastName: String) -> Bool {
        // проверяем нет ли запрещенных символов в имени и фамилии
        return true
    }
   
    // закрыть доступ выбирать др завтра
}
