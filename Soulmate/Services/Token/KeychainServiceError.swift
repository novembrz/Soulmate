//
//  KeychainServiceError.swift
//  Soulmate
//
//  Created by dasha on 24.03.2022.
//

import Foundation

enum KeychainServiceError {
    case readError
    case saveError
    case encodeDataError
    case decodeDataError
    case checkRefreshToken
}


extension KeychainServiceError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .readError:
            return NSLocalizedString("🔑 Ошибка чтения данных из цепочки ключей", comment: "")
        case .saveError:
            return NSLocalizedString("🔑 Ошибка сохранения в цепочку ключей", comment: "")
        case .encodeDataError:
            return NSLocalizedString("🔑 Не удается закодировать данные для цепочки ключей:", comment: "")
        case .decodeDataError:
            return NSLocalizedString("🔑 Не удается раскодировать данные для цепочки ключей:", comment: "")
        case .checkRefreshToken:
            return NSLocalizedString("🔑 Refresh tokens не совпали, не удалось получить новые токены", comment: "")
        }
    }
}
