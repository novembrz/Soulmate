//
//  AuthValidators.swift
//  Soulmate
//
//  Created by dasha on 18.01.2022.
//

import Foundation
import SwiftUI


final class AuthValidators {
    
    static func canRegister(login: String, email: String, password: String, confirmPassword: String, completion: @escaping (Result) -> Void) {
        guard isRegisterFilled(login: login, email: email, password: password, confirmPassword: confirmPassword) else { return completion(.failure(AuthError.notFilled)) }
        guard password == confirmPassword else { return completion(.failure(AuthError.notEqualPasswords)) }
        guard isDifficultPassword(password) else { return completion(.failure(AuthError.easyPassword)) }
        guard isSimpleEmail(email) else { return completion(.failure(AuthError.invalidEmail)) }
        guard freeEmail(email) else { return completion(.failure(AuthError.registeredEmail)) }
        guard freeLogin(login) else { return completion(.failure(AuthError.registeredLogin)) }
        completion(.success)
    }
    
    static func canSignIn(login: String, password: String, completion: @escaping (Result) -> Void) {
        guard !login.isEmpty,
              !password.isEmpty
        else { return completion(.failure(AuthError.notFilled)) }
        completion(.success)
    }
    
    static func canFinishRegistration(name: String, lastName: String, birthDay: String, city: String, completion: @escaping (Result) -> Void) {
        guard isRegisterFilled(login: name, email: lastName, password: city, confirmPassword: birthDay) else { return completion(.failure(AuthError.notFilled)) }
        // Корректно ли имя, корректна ли фамилия, возраст ограничь еще в пикере
    }
    
    
    
    //MARK: - isFilled - можно ли в одну функцию
    
    static private func isRegisterFilled(login: String, email: String, password: String, confirmPassword: String) -> Bool {
        guard !login.isEmpty,
              !email.isEmpty,
              !password.isEmpty,
              !confirmPassword.isEmpty else { return false }
        return true
    }
    
    static private func isProfileDataFilled(firstName: String?, lastName: String?, profession: [UserProfessions]?) -> Bool {
        guard !(firstName ?? "").isEmpty,
              !(lastName ?? "").isEmpty,
              !(profession ?? []).isEmpty else { return false }
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
    
    
    //MARK: - Success data
    
    static private func isDifficultPassword(_ password: String) -> Bool {
        return true
    }
    
    static private func isSuccessName(name: String, lastName: String) -> Bool {
        // проверяем нет ли запрещенных символов в имени и фамилии
        return true
    }
}
