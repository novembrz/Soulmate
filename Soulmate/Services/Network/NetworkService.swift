//
//  NetworkService.swift
//  Soulmate
//
//  Created by dasha on 05.12.2021.
//

import Foundation


final class NetworkService {
    
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
