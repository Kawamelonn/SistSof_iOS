//
//  Actividad.swift
//  SEL4C
//
//  Created by César Andrés Ceballos Castillo on 08/10/23.
//

import Foundation



struct Actividad:Codable{
    let id:Int
    let completado:Bool
    
}
typealias Actividades = [Actividad]

enum ActividadError: Error, LocalizedError{
    case itemNotFound
}

extension Actividad{
    
    
    static func fetchQuestions(usuario:Int) async throws->Actividades{
        let id_usuario = usuario
        let baseString = "http://127.0.0.1:8000/cac/\(id_usuario)/"
        let questionsURL = URL(string: baseString)!
        let (data, response) = try await URLSession.shared.data(from: questionsURL)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw ActividadError.itemNotFound
        }
        
        /*
        if let dataString = String(data: data, encoding: .utf8) {
                print("Datos recibidos: \(dataString)")
            } else {
                print("No se pudo convertir los datos a cadena.")
            }
         */
        
        let jsonDecoder = JSONDecoder()
        let actividades = try? jsonDecoder.decode(Actividades.self, from: data)
        print("-------------")
        return actividades!
        
    }
}
