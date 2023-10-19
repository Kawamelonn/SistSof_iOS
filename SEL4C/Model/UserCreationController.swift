//
//  UserCreationController.swift
//  SEL4C
//
//  Created by Ivan HM on 08/10/23.
//


import Foundation

enum UserCreationError: Error, LocalizedError {
    case itemNotFound
    case requestFailed
    case invalidResponse
}

class UserCreationController {
    let baseString = "http://127.0.0.1:8000/crear_usuario/"
    
    func insertUser(newUsuario: Usuario) async throws -> Void {
        let insertURL = URL(string: baseString)!
        var request = URLRequest(url: insertURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(newUsuario)
            request.httpBody = jsonData
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw UserCreationError.invalidResponse
            }
        } catch {
            throw UserCreationError.requestFailed
        }
    }
}
