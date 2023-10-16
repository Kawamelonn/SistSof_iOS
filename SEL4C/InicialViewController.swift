//
//  InicialViewController.swift
//  SEL4C
//
//  Created by Usuario on 10/10/23.
//

import UIKit

class InicialViewController: UIViewController {

        @IBOutlet weak var textQuestion: UILabel!
        
        @IBOutlet weak var progressEcomplexity: UIProgressView!
        
        @IBOutlet weak var buttonNadaAcuerdo: UIButton!
        
        @IBOutlet weak var buttonPocoAcuderdo: UIButton!
        @IBOutlet weak var buttonNiAcuerdo: UIButton!
        
        @IBOutlet weak var buttonDeAcuerdo: UIButton!
        
        @IBOutlet weak var buttonMuyAcuerdo: UIButton!
        var engine = IndexEngine()
        var autodiagnosticoController = DiagnosticoController()
            
        override func viewDidLoad() {
            super.viewDidLoad()
            Task {
                do {
                    var allQuestions: Preguntas = [] // Inicializa un arreglo vacío para almacenar todas las preguntas
                    var currentPage = 1

                    while true {
                        do {
                            let questions = try await Question.fetchQuestions(page: currentPage)

                            if questions.isEmpty {
                                    // No hay más resultados, sal del bucle
                            break
                            }

                            allQuestions += questions // Agrega las preguntas de la página actual al arreglo total
                            currentPage += 1
                            } catch {
                                //displayError(QuestionError.itemNotFound, title: "No se pudo acceder a las preguntas")
                                break // En caso de error, sal del bucle
                            }
                        }
                        
                        print(allQuestions)
                        updateUI(with: allQuestions) // Llama a la función para actualizar la interfaz con todas las preguntas
                    } catch {
                        displayError(QuestionError.itemNotFound, title: "No se pudo acceder a las preguntas")
                    }
                }

                
            }
            func updateUI(with questions:Preguntas){
                DispatchQueue.main.async {
                    self.engine.initialize(q: questions)
                    self.progressEcomplexity.progress = self.engine.getProgress()
                    self.textQuestion.text = self.engine.getTextQuestion()
                }
            }
            func displayError(_ error: Error, title: String) {
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
    @IBAction func userAnswer(_ sender: UIButton) {
        let answer = sender.titleLabel?.text
        let question = SimplifiedQuestion(id: engine.getId(),text: engine.getTextQuestion())
        var ans = Answer(question: question, answer: 0)
        switch answer!{
        case let str where str.contains("Nada de acuerdo"):
            ans.answer = 1
            //print("Nada de acuerdo")
        case let str where str.contains("Poco de acuerdo"):
            ans.answer = 2
            //print("Poco de acuerdo")
        case let str where str.contains("Ni de acuerdo ni desacuerdo"):
            ans.answer = 3
            //print("Ni de acuerdo ni desacuerdo")
        case let str where str.contains("De acuerdo"):
            ans.answer = 4
            //print("De acuerdo")
        default:
            ans.answer = 5
            //print("Muy de acuerdo")
        }
        
        Task {
            do {
                try await crearAutodiagnostico(pregunta: question.id, respuesta: ans.answer)
                
            } catch {
                print("No se pudo mandar la respuesta al servidor.")
            }
        }
        
        sender.backgroundColor = UIColor.green
        buttonDeAcuerdo.isEnabled = false
        buttonNiAcuerdo.isEnabled = false
        buttonMuyAcuerdo.isEnabled = false
        buttonNadaAcuerdo.isEnabled = false
        buttonPocoAcuderdo.isEnabled = false
        
        if engine.nextQuestion(){
            print("No hay más preguntas")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
                               (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
            
        }else{
            print("questionIndex: \(engine.questionIndex)")
            print("Siguiente pregunta")
            Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: Selector("nextQuestion"), userInfo: nil, repeats: false)
        }
    }
                    
    func crearAutodiagnostico(pregunta: Int,respuesta: Int) async throws {
        var competencia = ""
        
        switch pregunta {
        case 1...4:
            competencia = "Autocontrol"
        case 5...10:
            competencia = "Liderazgo"
        case 11...17:
            competencia = "Conciencia y Valor Social"
        case 18...24:
            competencia = "Innovación Social y Sostenibilidad Financiera"
        case 25...30:
            competencia = "Pensamiento sistémico"
        case 31...37:
            competencia = "Pensamiento científico"
        case 38...43:
            competencia = "Pensamiento crítico"
        case 44...49:
            competencia = "Pensamiento innovador"
        default:
            // Manejo de un ID no válido
            print("ID de pregunta no válido")
            return
        }
        if let userIdPrueba = UserDefaults.standard.string(forKey: "UserId"), let userId = Int(userIdPrueba) {
            let newAutodiagnostico = RespuestaUsuario(
                num_auto: 1,
                usuario: userId,
                pregunta: pregunta,
                respuesta: respuesta,
                competencia: competencia,
                completada: true
            )
            
            print(newAutodiagnostico)
            
            // Envía el nuevo usuario a la base de datos
            do {
                try await autodiagnosticoController.insertDiagnostico(newDiagnostico: newAutodiagnostico)
                print("Datos enviados exitosamente")
            } catch {
                print("Error al enviar los datos: \(error)")
            }
        }
    }
    
    func updateUserResponses(title: String){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: "Datos almacenados con éxito", preferredStyle: .alert)
            let continueAction = UIAlertAction(title: "Continuar", style: .default)
                    alert.addAction(continueAction)
                    self.present(alert,animated: true)
        }
    }
    func displayErrorUserResponses(_ error: Error, title: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Continuar", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
        }
    }
                        
    @objc func nextQuestion(){
        textQuestion.text = engine.getTextQuestion()
        progressEcomplexity.progress = engine.getProgress()
        buttonDeAcuerdo.backgroundColor = UIColor.white
        buttonNiAcuerdo.backgroundColor = UIColor.white
        buttonMuyAcuerdo.backgroundColor = UIColor.white
        buttonNadaAcuerdo.backgroundColor = UIColor.white
        buttonPocoAcuderdo.backgroundColor = UIColor.white
        buttonDeAcuerdo.isEnabled = true
        buttonNiAcuerdo.isEnabled = true
        buttonMuyAcuerdo.isEnabled = true
        buttonNadaAcuerdo.isEnabled = true
        buttonPocoAcuderdo.isEnabled = true
    }
}
