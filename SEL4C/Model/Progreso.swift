//
//  Progreso.swift
//  SEL4C
//
//  Created by Usuario on 09/10/23.
//

import Foundation

struct Progreso: Encodable {
    var usuario: Int
    var actividad: Int
    var filename: String
    var file: String
    var completado: Bool
}
