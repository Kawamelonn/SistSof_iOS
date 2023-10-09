//
//  Respuesta.swift
//  SEL4C
//
//  Created by Andrea Samantha Aguilar on 29/09/23.
//

import Foundation

struct Respuesta:Codable{
    var pregunta:Pregunta
    var respuesta:Int
}

typealias Respuestas = [Respuesta]
