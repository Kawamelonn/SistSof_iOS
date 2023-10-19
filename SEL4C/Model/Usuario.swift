//
//  Usuario.swift
//  SEL4C
//
//  Created by  Ivan HM on 08/10/23.
//

import Foundation

struct Usuario: Encodable {
    var nombre: String
    var genero: String
    var grado: String
    var disciplina: String
    var pais: Int
    var institucion: Int
    var correo: String
    var username: String
    var password: String
}
