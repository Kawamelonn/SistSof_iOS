//
//  Instituciones.swift
//  SEL4C
//
//  Created by Andrea Samantha Aguilar on 08/10/23.
//

import Foundation

struct Question: Codable {
    let id: Int
    let tipo_pregunta: String
    let pregunta: String
}

struct Questions: Codable {
    let count: Int
    let results: [Question]
}

struct SimplifiedQuestion {
    let id: Int
    let text: String
}

typealias Preguntas = [SimplifiedQuestion]

enum QuestionError: Error, LocalizedError {
    case itemNotFound
}

extension Question {
    static func fetchQuestions(page: Int) async throws -> Preguntas {
        let baseString = "http://127.0.0.1:8000/Preguntas?page=\(page)"
        let preguntasURL = URL(string: baseString)!

        let (data, response) = try await URLSession.shared.data(from: preguntasURL)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw QuestionError.itemNotFound
        }
        let jsonDecoder = JSONDecoder()
        let questions = try jsonDecoder.decode(Questions.self, from: data)

        // Ahora mapeamos las preguntas completas a SimplifiedQuestion
        let simplifiedQuestions = questions.results.map { question in
            return SimplifiedQuestion(id: question.id, text: question.pregunta)
        }

        return simplifiedQuestions
    }
}


