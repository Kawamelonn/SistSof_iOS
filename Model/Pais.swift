//
//  Institucion.swift
//  SEL4C
//
//  Created by IvanHM on 07/10/23.
//

import Foundation

struct Pais: Codable {
    let id: Int
    let nombre: String
}

struct Paises: Codable {
    let count: Int
    let results: [Pais]
}


enum PaisError: Error, LocalizedError{
    case itemNotFound
}

extension Pais {
    static func fetchPaises(page: Int) async throws -> Paises {
        let baseString = "http://127.0.0.1:8000/Paises?page=\(page)" // Agrega la página a la URL
        let paisesURL = URL(string: baseString)!
        
        do {
            let (data, response) = try await URLSession.shared.data(from: paisesURL)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw PaisError.itemNotFound
            }
            
            let jsonDecoder = JSONDecoder()
            let paises = try jsonDecoder.decode(Paises.self, from: data)
            
            return paises
        } catch {
            throw error
        }
    }
}


