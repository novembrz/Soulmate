//
//  ResponseError.swift
//  Soulmate
//
//  Created by dasha on 24.03.2022.
//

import SwiftUI

enum NetworkResponseError {
    case authenticationError
    case badRequest
    case outdated
    case serverError
    case internetError
    case noData
    case unableToDecode
}

extension NetworkResponseError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .authenticationError:
            return NSLocalizedString("💔 Сначала вам нужно пройти проверку подлинности", comment: "")
        case .badRequest:
            return NSLocalizedString("💔 Неправильный запрос!", comment: "")
        case .outdated:
            return NSLocalizedString("💔 Запрошенный вами URL-адрес устарел", comment: "")
        case .serverError:
            return NSLocalizedString("💔 Ошибка выполнения запроса!", comment: "")
        case .internetError:
            return NSLocalizedString("💔 Ошибка подключения к сети интернет!", comment: "")
        case .noData:
            return NSLocalizedString("💔 Не удалось получить данные", comment: "")
        case .unableToDecode:
            return NSLocalizedString("💔💔 Не получилось декодировать данные", comment: "")
        }
    }
}
