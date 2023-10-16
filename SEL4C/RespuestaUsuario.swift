//
//  RespuestaUsuario.swift
//  SEL4C
//
//  Created by Usuario on 10/10/23.
//

import Foundation

struct RespuestaUsuario: Codable {
    let num_auto: Int
    let usuario: Int
    let pregunta: Int
    let respuesta: Int
    let competencia: String
    let completada: Bool
}
