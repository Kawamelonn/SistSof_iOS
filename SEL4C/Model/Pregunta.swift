//
//  Pregunta.swift
//  SEL4C
//
//  Created by Andrea Samantha Aguilar on 29/09/23.
//

import Foundation

struct Pregunta:Codable{
    let id:Int
    let text:String
    
}
typealias Preguntas = [Pregunta]

enum PreguntaError: Error, LocalizedError{
    case itemNotFound
}

extension Pregunta{
    
    static func fetchPregunta() async throws-> Preguntas{
        let baseString = "http://20.214.178.206:8000/Preguntas/"
        let preguntasURL = URL(string: baseString)!
        let (data, response) = try await URLSession.shared.data(from: preguntasURL)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw PreguntaError.itemNotFound
        }
        let jsonDecoder = JSONDecoder()
        let preguntas = try? jsonDecoder.decode(Preguntas.self, from: data)
        return preguntas!
        
    }
}
