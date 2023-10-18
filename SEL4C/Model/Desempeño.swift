//
//  Instituciones.swift
//  SEL4C
//
//  Created by Ivan HM on 18/10/23.
//

import Foundation

struct DesempeñoData: Codable {
    let autocontrolini: String
    let liderazgoini: String
    let concienciaini: String
    let innovacionini: String
    let sistemicoini: String
    let cientificoini: String
    let criticoini: String
    let innovadorini: String
    
    let autocontrolfin: String
    let liderazgofin: String
    let concienciafin: String
    let innovacionfin: String
    let sistemicofin: String
    let cientificofin: String
    let criticofin: String
    let innovadorfin: String
}

enum DesempeñoDataError: Error, LocalizedError{
    case itemNotFound
}

extension DesempeñoData {
    static func fetchDesempeñoData(id: Int) async throws -> DesempeñoData {
        let baseString = "http://127.0.0.1:8000/desempeno_usuario/\(id)"
        let dataURL = URL(string: baseString)!
       
        do {
            let (data, response) = try await URLSession.shared.data(from: dataURL)
           
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw DesempeñoDataError.itemNotFound
            }
           
            let jsonDecoder = JSONDecoder()
            let datos = try jsonDecoder.decode(DesempeñoData.self, from: data)
           
            return datos
        } catch {
            throw error
        }
    }
}

