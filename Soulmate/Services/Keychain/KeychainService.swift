//
//  KeychainService.swift
//  Soulmate
//
//  Created by dasha on 15.02.2022.
//

import Foundation


final class KeychainService {
    
    static let standard = KeychainService()
    private init() {}
    private let service = "soulmate.com"
    
    
    func save(_ data: Data, account: String) {
        let query = [
            kSecValueData: data,
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword
        ] as CFDictionary
        
        //сохранить значение - добавить информацию в связку ключей
        let status = SecItemAdd(query, nil)
        
        if status == errSecDuplicateItem {
            resave(data, account: account)
        }
    }
    
    private func resave(_ data: Data, account: String) {
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword,
        ] as CFDictionary
        
        let attributesToUpdate = [kSecValueData: data] as CFDictionary
        
        SecItemUpdate(query, attributesToUpdate)
    }
    
    
    func read(account: String) -> Data? {
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword,
            kSecReturnData: true
        ] as CFDictionary
        
        var result: AnyObject?
        SecItemCopyMatching(query, &result)
        
        return (result as? Data)
    }
    
    
    func delete(service: String, account: String) {
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword,
            ] as CFDictionary
        
        SecItemDelete(query)
    }
}

//MARK: extension
extension KeychainService {
    //newAccountName(Dasha), item(password, token), service("Soulmate")
    
    func save<T: Codable>(_ item: T, account: String) {
        do {
            let data = try JSONEncoder().encode(item)
            save(data, account: account)
        } catch {
            assertionFailure("Fail to encode item for keychain: \(error)")
        }
    }
    
    func read<T: Codable>(account: String, type: T.Type) -> T? {
        guard let data = read(account: account) else {
            return nil
        }
        
        do {
            let item = try JSONDecoder().decode(type, from: data)
            return item
        } catch {
            assertionFailure("Fail to decode item for keychain: \(error)")
            return nil
        }
    }
    
}
