//
//  RespuestasInicialController.swift
//  SEL4C
//
//  Created by Usuario on 10/10/23.
//

import Foundation

enum DiagnosticoError: Error, LocalizedError{
    case itemNotFound
}
class DiagnosticoController{
    let baseString = "http://127.0.0.1:8000/crear_autodiagnostico/"
    
    func insertDiagnostico(newDiagnostico:RespuestaUsuario)async throws->Void{
        let insertURL = URL(string: baseString)!
        var request = URLRequest(url: insertURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(newDiagnostico)
        request.httpBody = jsonData
        print("jsonData value")
        let jsonString = String(data: jsonData!, encoding: .utf8)!
            //Imprimes el json.
            print(jsonString)
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else { throw DiagnosticoError.itemNotFound}
    }
    
}
