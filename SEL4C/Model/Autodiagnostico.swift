//
//  AutodiagnosticoActividad.swift
//  SEL4C
//
//  Created by César Andrés Ceballos Castillo on 09/10/23.
//

import Foundation



struct Autodiagnostico:Codable{
    let usuario_id:Int
    let preguntaFinalCompletada:Bool
    
}
typealias Autodiagnosticos = [Autodiagnostico]

enum AutodiagnosticoError: Error, LocalizedError{
    case itemNotFound
}

extension Autodiagnostico{
    
    
    static func fetchAutodiagnostico(usuario:Int, num_aut:Int) async throws->Autodiagnosticos{
        let id_usuario = usuario
        let id_auto = 1
        let baseString = "http://20.124.95.5:8000/cauto/\(id_usuario)/\(id_auto)/"
        let autosURL = URL(string: baseString)!
        let (data, response) = try await URLSession.shared.data(from: autosURL)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw AutodiagnosticoError.itemNotFound
        }
        
        
        if let dataString = String(data: data, encoding: .utf8) {
                print("Datos recibidos: \(dataString)")
            } else {
                print("No se pudo convertir los datos a cadena.")
            }
         
        
        let jsonDecoder = JSONDecoder()
        let autodiagnosticos = try? jsonDecoder.decode(Autodiagnosticos.self, from: data)
        print("-------------")
        print("Datos dentro del array: \(autodiagnosticos!)")
        return autodiagnosticos!
        
    }
}
