//
//  IndexEngine.swift
//  SEL4C
//
//  Created by Andrea Samantha Aguilar on 29/09/23.
//

import Foundation

struct  IndexEngine{
    var questionIndex = 0
    var questions=Preguntas()
    mutating func initialize(q:Preguntas){
        questions = q
    }
    func getTextQuestion()->String{
        return questions[questionIndex].text
    }
    func getId()->Int{
        return questions[questionIndex].id
    }
    func getProgress()->Float{
        let progress = Float(questionIndex+1)/Float(questions.count)
        return progress
    }
    mutating func nextQuestion()->Bool{
        if questionIndex == 48 {
            questionIndex=0
            return true
        }
        else{
            questionIndex += 1
            return false
        }
    }
}



