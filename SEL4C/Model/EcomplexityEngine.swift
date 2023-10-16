//
//  EcomplexityEngine.swift
//  SEL4C
//
//  Created by César Andrés Ceballos Castillo on 08/10/23.
//

import Foundation

struct EcomplexityEngine{
    var actividadIndex = 0
    var autoIndex = 0
    var userIndex = 0
    var actividades=Actividades()
    var autodiagnosticos=Autodiagnosticos()
    var perfiles=Perfiles()
    
    
    mutating func initialize(q:Actividades){
        actividades = q
    }
    
    mutating func initializeAuto(qq:Autodiagnosticos){
        autodiagnosticos = qq
    }
    
    mutating func initializePerfil(qqq: Perfiles){
        perfiles = qqq
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
    
    func getNombre()->String{
        guard userIndex >= 0 && userIndex < perfiles.count else {
            print("valió cake")
                return("Sin Nombre") // o cualquier otro valor predeterminado si el índice es inválido
            }
        return perfiles[userIndex].nombre
    }
    
    func getUsuario()->String{
        guard userIndex >= 0 && userIndex < perfiles.count else {
            print("valió cake")
                return("Sin Usuario") // o cualquier otro valor predeterminado si el índice es inválido
            }
        return perfiles[userIndex].username
    }
    
    func getCorreo()->String{
        guard userIndex >= 0 && userIndex < perfiles.count else {
            print("valió cake")
                return("Sin Nombre") // o cualquier otro valor predeterminado si el índice es inválido
            }
        return perfiles[userIndex].correo
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
        if autoIndex+1 < autodiagnosticos.count{
            autoIndex += 1
            return false
        }
        else{
            autoIndex = 0
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
