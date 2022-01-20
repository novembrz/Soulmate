//
//  KeychainHelper.swift
//  Soulmate
//
//  Created by dasha on 19.01.2022.
//

import Foundation


final class KeychainHelper {
    
    static let standard = KeychainHelper()
    private init() {}
    
    
    //MARK: - save
    
    func save<T>(_ item: T, service: String, account: String) where T : Codable {
        do {
            let data = try JSONEncoder().encode(item) // Encode as JSON data and save in keychain
            save(data, service: service, account: account)
        } catch {
            assertionFailure("Fail to encode item for keychain: \(error)")
        }
    }
    
    
    private func save(_ data: Data, service: String, account: String) {
        let query = [ // Создаем запрос
            kSecValueData: data,
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account,
        ] as CFDictionary
        
        
        let status = SecItemAdd(query, nil) // Add data in query to keychain
        
        if status != errSecSuccess {
            print("Error: \(status)")
        }
        
        if status == errSecDuplicateItem {
            resave(data, service: service, account: account)
        }
    }
    
    
    private func resave(_ data: Data, service: String, account: String) {
        // Item already exist, thus update it.
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword,
        ] as CFDictionary
        
        let attributesToUpdate = [kSecValueData: data] as CFDictionary
        
        // Update existing item
        SecItemUpdate(query, attributesToUpdate)
    }
    
    
    //MARK: - read
    
    func read<T>(service: String, account: String, type: T.Type) -> T? where T : Codable {
        // Read item data from keychain
        guard let data = read(service: service, account: account) else {
            return nil
        }
        
        do { // Decode JSON data to object
            let item = try JSONDecoder().decode(type, from: data)
            return item
        } catch {
            assertionFailure("Fail to decode item for keychain: \(error)")
            return nil
        }
    }
    
    func read(service: String, account: String) -> Data? {
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
    
    
    //MARK: - delete
    
    func delete(service: String, account: String) {
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword,
            ] as CFDictionary
        
        // Delete item from keychain
        SecItemDelete(query)
    }
}


//MARK: - save usage
/*
 let accessToken = "dummy-access-token"
 let data = Data(accessToken.utf8)
 KeychainHelper.standard.save(data, service: "access-token", account: "facebook")
 */


//MARK: - read
/*
 let data = KeychainHelper.standard.read(service: "access-token", account: "facebook")!
 let accessToken = String(data: data, encoding: .utf8)!
 print(accessToken)
 */


//MARK: - Auth Service
/*
 struct Auth: Codable {
     let accessToken: String
     let refreshToken: String
 }

 // Create an object to save
 let auth = Auth(accessToken: "dummy-access-token",
                  refreshToken: "dummy-refresh-token")

 let account = "domain.com"
 let service = "token"

 // Save `auth` to keychain
 KeychainHelper.standard.save(auth, service: service, account: account)

 // Read `auth` from keychain
 let result = KeychainHelper.standard.read(service: service,
                                           account: account,
                                           type: Auth.self)!

 print(result.accessToken)   // Output: "dummy-access-token"
 print(result.refreshToken)  // Output: "dummy-refresh-token"
 */


//MARK: - Dictionary
/*
 kSecValueData: ключ, представляющий данные, сохраняемые в связке ключей.
 kSecClass: ключ, представляющий тип сохраняемых данных. Здесь мы устанавливаем его значение, kSecClassGenericPasswordуказывающее, что данные, которые мы сохраняем, являются общим элементом пароля.
 kSecAttrServiceи kSecAttrAccount: Эти 2 клавиши являются обязательными, если kSecClassустановлено значение kSecClassGenericPassword. Значения обоих этих ключей будут выступать в качестве первичного ключа для сохраняемых данных. Другими словами, мы будем использовать их для извлечения сохраненных данных из цепочки для ключей позже.
 
 Например, если мы сохраняем токен доступа Facebook, мы можем установить kSecAttrService как « токен доступа » и kSecAttrAccountкак « facebook ».
 */
