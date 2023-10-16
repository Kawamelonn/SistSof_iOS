//
//  Perfil.swift
//  SEL4C
//
//  Created by Andrea Samantha Aguilar on 11/10/23.
//

import Foundation

struct Perfil: Codable {
    var nombre: String
    var correo: String
    var username: String
}



typealias Perfiles = [Perfil]

enum PerfilError: Error, LocalizedError{
    case itemNotFound
}

extension Perfil{
    
    
    static func fetchPerfiles(id_usuario: Int) async throws->Perfiles{
        let id_user = id_usuario
        let baseString = "http://20.124.95.5:8000/perfil/\(id_user)/"
        let perfilURL = URL(string: baseString)!
        let (data, response) = try await URLSession.shared.data(from: perfilURL)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else{
            throw PerfilError.itemNotFound
        }
        
        if let dataString = String(data: data, encoding: .utf8) {
                print("Datos recibidos: \(dataString)")
            } else {
                print("No se pudo convertir los datos a cadena.")
            }
        
        let jsonDeocder = JSONDecoder()
        let perfiles = try? jsonDeocder.decode(Perfiles.self, from: data)
        return perfiles!
    }
    
}
