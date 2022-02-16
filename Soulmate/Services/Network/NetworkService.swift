//
//  NetworkService.swift
//  Soulmate
//
//  Created by dasha on 05.12.2021.
//

import Foundation


final class NetworkService {
    
    
    //MARK: - fetchData
    
    static func fetchData<T: Decodable>(urlString: String, completion: @escaping (T?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { data, _, error in
            if let error = error {
                print("💔💔💔 ", error.localizedDescription)
                return
            }
            
            let decoded = decodeJSON(type: T.self, from: data)
            completion(decoded)
        }
        task.resume()
    }
    
    
    //MARK: - postData
    
    static func postData(param: [String: Any], urlString: String, completion: @escaping (Result) -> Void) {
        let urlString = "http://localhost:8082/api/auth/signin"
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: param, options: []),
              let url = URL(string: urlString)
        else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")  // the request is JSON
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")        // the expected response is also JSON
//        request.addValue("Basic \(jsonData)", forHTTPHeaderField: "Authorization") //мб только его надо
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil || (response as! HTTPURLResponse).statusCode != 200 {
                print("💔", (response as! HTTPURLResponse).statusCode)
                completion(.failure(AuthError.serverError))
                return
            }
            
            if let decode = NetworkService.decodeJSON(type: SignInResponse.self, from: data) {
                print("✅", decode)
                KeychainService.standard.save(decode, account: "access-token")
                
                completion(.success)
            }
        }
        task.resume()
    }
    
    
    //MARK: - decode
    
    static func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }
        
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let error {
            print("💔 ", error.localizedDescription)
            return nil
        }
    }
}
