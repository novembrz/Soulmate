//
//  AuthService.swift
//  Soulmate
//
//  Created by dasha on 17.01.2022.
//

import Combine
import Foundation


enum AuthResult {
    case success(SignInResponse) //можно пустой, просто сукес
    case failure(Error)
}


struct SignInResponse: Decodable { //вернет при сайн ин только токен, если еще что-то надо - расширяй
    let accessToken: String
}


final class AuthService {
    
    //Возможно когда будет абстракция нужно будет передавать свой респонс, у всех же свои параметры
    static func postData(param: [String: Any], completion: @escaping (AuthResult) -> Void) {
        let urlString = "http://localhost:8082/api/auth/signin"
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: param, options: []),
              let url = URL(string: urlString)
        else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")  // the request is JSON
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")        // the expected response is also JSON
        request.addValue("Basic \(jsonData)", forHTTPHeaderField: "Authorization") //мб только его надо
        request.httpBody = jsonData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil || (response as! HTTPURLResponse).statusCode != 200 {
                completion(.failure(error!))
                return
            }
            
            if let decode = NetworkService.decodeJSON(type: SignInResponse.self, from: data) {
                print("✅", decode)
                // TODO: Cache Access Token in Keychain
                // // получение - let key = UserDefaults.standard.object(forKey: "loginKey") as! String
                completion(.success(decode))
            }
        }
        task.resume()
    }
}
