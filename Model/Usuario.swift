//
//  Usuario.swift
//  SEL4C
//
//  Created by Margarita Mendoza on 05/10/23.
//

import Foundation

struct Usuario: Encodable {
    var nombre: String
    var genero: String
    var grado: String
    var disciplina: String
    var pais: Int // ID País
    var institucion: Int // ID Institución
    var correo: String
    var username: String
    var password: String
}

