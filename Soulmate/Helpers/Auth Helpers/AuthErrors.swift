//
//  AuthResult.swift
//  Soulmate
//
//  Created by dasha on 18.01.2022.
//

import Foundation


enum AuthError {
    case notFilled
    case invalidEmail
    case registeredEmail
    case registeredLogin
    case notEqualPasswords
    case easyPassword
    case dataError
}


extension AuthError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notFilled:
            return NSLocalizedString("Необходимо заполнить все поля!", comment: "")
        case .invalidEmail:
            return NSLocalizedString("Неверный формат почты", comment: "")
        case .registeredEmail:
            return NSLocalizedString("Данная почта уже зарегестрированна", comment: "")
        case .registeredLogin:
            return NSLocalizedString("Данный логин уже зарегестрирован", comment: "")
        case .notEqualPasswords:
            return NSLocalizedString("Пароли не совпадают", comment: "")
        case .easyPassword:
            return NSLocalizedString("Пароль должен быть длиннее 8 символов и содержать буквы в верхнем и нижнем регистре, спец символы и цифры", comment: "")
        case .dataError:
            return NSLocalizedString("Неверное имя пользователя или пароль", comment: "")
        }
    }
}
