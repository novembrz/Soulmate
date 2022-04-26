//
//  UserDefaultsStorage.swift
//  Soulmate
//
//  Created by dasha on 26.04.2022.
//

import SwiftUI


@propertyWrapper

struct Storage<T: Codable> {
    private let key: String
    private let defaultValue: T
    
    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T {
        get {
            guard let data = UserDefaults.standard.object(forKey: key) as? Data else {
                return defaultValue
            }
            
            let value = try? JSONDecoder().decode(T.self, from: data)
            return value ?? defaultValue
        }
        
        set {
            let data = try? JSONEncoder().encode(newValue)
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}


//MARK: remove

extension UserDefaultsProperties {
    static func removeBy(key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
