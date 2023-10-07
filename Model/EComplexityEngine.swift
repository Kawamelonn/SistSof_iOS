//
//  EComplexityEngine.swift
//  SEL4C
//
//  Created by Margarita Mendoza on 07/10/23.
//

import Foundation

struct EcomplexityEngine{
    var institucionIndex = 0
    var instituciones=Instituciones
    mutating func initialize(i:Instituciones){
        instituciones = i
    }
    func getTextInstitucion()->String{
        return instituciones[institucionIndex].nombre
    }
    func getId()->Int{
        return instituciones[institucionIndex].id
    }
}
