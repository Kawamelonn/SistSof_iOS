//
//  ProgresoCreationController.swift
//  SEL4C
//
//  Created by Usuario on 09/10/23.
//

import Foundation

enum ProgressCreationError: Error, LocalizedError {
    case itemNotFound
    case requestFailed
    case invalidResponse
}

class ProgressCreationController {
    let baseString = "http://127.0.0.1:8000/crear_progreso/"
    
    func insertProgreso(newProgreso: Progreso) async throws -> Void {
        let insertURL = URL(string: baseString)!
        var request = URLRequest(url: insertURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(newProgreso)
            request.httpBody = jsonData
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw ProgressCreationError.invalidResponse
            }
        } catch {
            throw ProgressCreationError.requestFailed
        }
    }
}
