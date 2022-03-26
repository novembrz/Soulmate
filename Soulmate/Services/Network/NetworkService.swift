//
//  NetworkService.swift
//  Soulmate
//
//  Created by dasha on 05.12.2021.
//

import Foundation


final class NetworkService {
    
    //MARK: - GET
    
    static func fetchData<T: Decodable>(urlString: String, completion: @escaping (Result, T?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil {
                print("💔💔💔", error!.localizedDescription)
                if error!.localizedDescription == "The Internet connection appears to be offline." {
                    completion(.failure(NetworkResponseError.internetError), nil)
                } else {
                    completion(.failure(NetworkResponseError.serverError), nil)
                }
                return
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    let decoded = decodeJSON(type: T.self, from: data)
                    completion(.success, decoded)
                case .failure(let error):
                    completion(.failure(error), nil)
                }
            }
        }
        task.resume()
    }
    
    
    //MARK: - POST
    
    static func postData<T: Decodable>(param: [String: Any], urlString: String, completion: @escaping (Result, T?) -> Void) {
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
    
    static private func sendRequest<T: Decodable>(_ request: URLRequest, completion: @escaping (Result, T?) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if error != nil {
                print("💔💔💔", error!.localizedDescription)
                completion(.failure(NetworkResponseError.serverError), nil)
                return
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    if let decode = NetworkService.decodeJSON(type: T.self, from: data) {
                        completion(.success, decode)
                    }
                case .failure(let networkFailureError):
                    completion(.failure(networkFailureError), nil)
                }
            }
        }
        task.resume()
    }
    
    
    //MARK: - decode
    
    static private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else {
            print(NetworkResponseError.noData)
            return nil
        }
        
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch {
            print(NetworkResponseError.unableToDecode)
            return nil
        }
    }
    
    
    //MARK: - NetworkResponse
    
    static private func handleNetworkResponse(_ response: HTTPURLResponse) -> Result {
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponseError.authenticationError)
        case 501...599: return .failure(NetworkResponseError.badRequest)
        case 600: return .failure(NetworkResponseError.outdated)
        default: return .failure(NetworkResponseError.serverError)
        }
    }
}
