//
//  IndexEngine.swift
//  SEL4C
//
//  Created by Andrea Samantha Aguilar on 29/09/23.
//

import Foundation

struct IndexEngine{
    var preguntaIndex = 0
    var preguntas = Preguntas()
    mutating func initialize(p:Preguntas){
        preguntas = p
    }
    func getTextPregunta()->String{
        return preguntas[preguntaIndex].text
    }
    func getId()->Int{
        return preguntas[preguntaIndex].id
    }
    func getProgress()->Float{
        let progress = Float(preguntaIndex+1)/Float(preguntas.count)
        return progress
    }
    mutating func nextQuestion()->Bool{
        if preguntaIndex+1 < preguntas.count{
            preguntaIndex += 1
            return false
        }
        else{
            preguntaIndex=0
            return true
        }
    }
}
