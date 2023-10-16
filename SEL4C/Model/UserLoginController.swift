//
//  UserLoginController.swift
//  SEL4C
//
//  Created by César Andrés Ceballos Castillo on 09/10/23.
//

import Foundation

struct UserCredentials: Codable {
    var username: String
    var password: String
}

struct UserLoginResponse: Codable {
    var message: String
    var id: Int
}

enum UserLoginError: Error, LocalizedError {
    case itemNotFound
    case invalidResponse
}

class UserLoginController {
    let baseUrlString = "http://127.0.0.1:8000/SEL4C/user-login/"

    func login(username: String, password: String, completion: @escaping (Result<UserLoginResponse, Error>) -> Void) {
        let userCredentials = UserCredentials(username: username, password: password)
        print("Estas son las user Credentials ;): \(userCredentials)")
        do {
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(userCredentials)
            print("Esta es la JSON data: \(jsonData)")
            
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print("Datos JSON enviados en la solicitud POST:")
                print(jsonString)
            }else {
                print("No se pudo convertir el JSON en una cadena.")
            }

            guard let url = URL(string: baseUrlString) else {
                completion(.failure(UserLoginError.itemNotFound))
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData

            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                    print("Valió aquí")
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(UserLoginError.itemNotFound))
                    print("Valió acá")
                    return
                }

                if httpResponse.statusCode == 200 {

                    if let responseData = data {
                        do {

                            let userLoginResponse = try
                            JSONDecoder().decode(UserLoginResponse.self, from: responseData)

                            let userId = userLoginResponse.id
                            
                                UserDefaults.standard.set(userId, forKey: "UserId")
                                    UserDefaults.standard.synchronize()
                                
                            
                            
                            completion(.success(userLoginResponse))
                        } catch {
                            completion(.failure(error))
                        }
                    } else {
                        print("No, aquí estuvo")
                        completion(.failure(UserLoginError.invalidResponse))
                    }
                } else {
                    print("Fue acaaaa")
                    completion(.failure(UserLoginError.itemNotFound))
                }
            }

            task.resume()
        } catch {
            print("Error al codificar los datos en formato JSON: \(error.localizedDescription)")
            completion(.failure(error))
        }
    }
}
