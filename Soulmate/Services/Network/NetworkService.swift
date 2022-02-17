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
        guard let jsonData = try? JSONSerialization.data(withJSONObject: param, options: []),
              let url = URL(string: urlString)
        else { return }
        
        let request = createRequest(url: url, jsonData: jsonData)
        sendRequest(request, completion: completion)
    }
    
    
    //MARK: - create request
    
    static private func createRequest(url: URL, jsonData: Data) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
        request.httpBody = jsonData
        return request
    }
    
    
    //MARK: - send Request
    
    static private func sendRequest(_ request: URLRequest, completion: @escaping (Result) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil || (response as! HTTPURLResponse).statusCode != 200 {
                print("💔", (response as! HTTPURLResponse).statusCode)
                completion(.failure(AuthError.serverError))
                return
            }
            
            if let decode = NetworkService.decodeJSON(type: SignInResponse.self, from: data) {
                KeychainService.standard.save(AuthToken(accessToken: decode), account: "access-token")
                completion(.success)
            }
        }
        task.resume()
    }
    
    
    //MARK: - decode
    
    static private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
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
