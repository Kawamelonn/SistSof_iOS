//
//  EcomplexityEngine.swift
//  SEL4C
//
//  Created by César Andrés Ceballos Castillo on 08/10/23.
//

import Foundation

struct EcomplexityEngine{
    var actividadIndex = 0
    let autoIndex = 0
    var actividades=Actividades()
    var autodiagnosticos=Autodiagnosticos()
    
    
    mutating func initialize(q:Actividades){
        actividades = q
    }
    
    mutating func initializeAuto(qq:Autodiagnosticos){
        autodiagnosticos = qq
    }
    
    func getID()->Int{
        guard actividadIndex >= 0 && actividadIndex < actividades.count else {
                return -1 // o cualquier otro valor predeterminado si el índice es inválido
            }
        return actividades[actividadIndex].id
    }
    func getStatus()->Bool{
        guard actividadIndex >= 0 && actividadIndex < actividades.count else {
            print("Actividades count: \(actividades.count)")
            print(actividades)
                return false // o cualquier otro valor predeterminado si el índice es inválido
            }
        return actividades[actividadIndex].completado
    }
    
    func getAutoId()->Int{
        guard autoIndex >= 0 && autoIndex < autodiagnosticos.count else {
                return -1 // o cualquier otro valor predeterminado si el índice es inválido
            }
        return autodiagnosticos[autoIndex].usuario_id
    }
    
    func getAutoStatus()->Bool{
        guard autoIndex >= 0 && autoIndex < autodiagnosticos.count else {
            print("valió cake")
            print(autodiagnosticos)
            print(autodiagnosticos.count)
                return false // o cualquier otro valor predeterminado si el índice es inválido
            }
        return autodiagnosticos[autoIndex].preguntaFinalCompletada
    }
    
    
    mutating func nextQuestion()->Bool{
        if actividadIndex+1 < actividades.count{
            actividadIndex += 1
            return false
        }
        else{
            actividadIndex=0
            return true
        }
    }
    
    mutating func nextAuto()->Bool{
        if actividadIndex+1 < actividades.count{
            actividadIndex += 1
            return false
        }
        else{
            actividadIndex=0
            return true
        }
    }
    /*
    func getUsuario()->String{
        guard actividadIndex >= 0 && actividadIndex < actividades.count else {
                return -1 // o cualquier otro valor predeterminado si el índice es inválido
            }
        return usuarios[usuarioIndex].id
    }
    */
}
