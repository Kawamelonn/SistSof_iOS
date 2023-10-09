//
//  Institucion.swift
//  SEL4C
//
//  Created by IvanHM on 07/10/23.
//

import Foundation

struct Institucion: Codable {
    let id: Int
    let nombre: String
}

struct Instituciones: Codable {
    let count: Int
    let results: [Institucion]
}


enum InstitucionError: Error, LocalizedError{
    case itemNotFound
}

extension Institucion {
    static func fetchInstituciones(page: Int) async throws -> Instituciones {
        let baseString = "http://127.0.0.1:8000/Instituciones?page=\(page)"
        let institucionesURL = URL(string: baseString)!
        
        do {
            let (data, response) = try await URLSession.shared.data(from: institucionesURL)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw InstitucionError.itemNotFound
            }
            
            let jsonDecoder = JSONDecoder()
            let instituciones = try jsonDecoder.decode(Instituciones.self, from: data)
            
            return instituciones
        } catch {
            throw error
        }
    }
}

