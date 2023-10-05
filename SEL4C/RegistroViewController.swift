//
//  RegistroViewController.swift
//  SEL4C
//
//  Created by César Andrés Ceballos Castillo on 30/08/23.
//

import UIKit

class RegistroViewController: UIViewController {
    
    @IBOutlet weak var paisOptions: UIButton!
    
    @IBOutlet weak var institucionOptions: UIButton!
    @IBOutlet weak var disciplinaOptions: UIButton!
    
    @IBOutlet weak var generoOptions: UIButton!
    
    @IBOutlet weak var gradoOptions: UIButton!
    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var correo: UITextField!
    @IBOutlet weak var nombre: UITextField!
    @IBOutlet weak var textView: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTextView()
        setPullDown()
        optionsGenero()
        optionsDisciplina()
        fetchInstitucionesFromEndpoint()
        fetchPaisesFromEndpoint()

    }
    
    func setPullDown() {
          let optionClosure = { (action: UIAction) in
              self.gradoOptions.setTitle(action.title, for: .normal)
          }
          
          let menu = UIMenu(title: "Selecciona un grado", children: [
              UIAction(title: "Pregrado", state: .on, handler: optionClosure),
              UIAction(title: "Posgrado", handler: optionClosure),
              UIAction(title: "Educación Continua", handler: optionClosure)
          ])
          
          gradoOptions.showsMenuAsPrimaryAction = true
          gradoOptions.menu = menu
      }
    
    func optionsGenero() {
          let optionClosure = { (action: UIAction) in
              self.generoOptions.setTitle(action.title, for: .normal)
          }
          
          let menu = UIMenu(title: "Selecciona una opción", children: [
              UIAction(title: "Masculino", state: .on, handler: optionClosure),
              UIAction(title: "Femenino", handler: optionClosure),
              UIAction(title: "No binario", handler: optionClosure),
              UIAction(title: "Prefiero no decir", handler: optionClosure)
          ])
          
          generoOptions.showsMenuAsPrimaryAction = true
          generoOptions.menu = menu
      }
    
    func optionsDisciplina() {
          let optionClosure = { (action: UIAction) in
              self.disciplinaOptions.setTitle(action.title, for: .normal)
          }
          
          let menu = UIMenu(title: "Selecciona una opción", children: [
              UIAction(title: "Ingeniería y Ciencias", state: .on, handler: optionClosure),
              UIAction(title: "Humanidades y Educación", handler: optionClosure),
              UIAction(title: "Ciencias Sociales", handler: optionClosure),
              UIAction(title: "Ciencias de la Salud", handler: optionClosure),
              UIAction(title: "Arquitectura, Arte y Diseño", handler: optionClosure),
              UIAction(title: "Negocios", handler: optionClosure)
          ])
          
          disciplinaOptions.showsMenuAsPrimaryAction = true
          disciplinaOptions.menu = menu
      }
    
    func fetchInstitucionesFromEndpoint() {
        guard let url = URL(string: "http://127.0.0.1:8000/Instituciones/") else {
            print("URL inválida")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error al realizar la solicitud: \(error)")
                return
            }
            
            guard let data = data else {
                print("No se recibieron datos")
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    if let results = json["results"] as? [[String: String]] {
                        var menuActions: [UIAction] = []
                        
                        for item in results {
                            if let nombre = item["nombre"] {
                                let action = UIAction(title: nombre, handler: { [weak self] _ in
                                    self?.institucionOptions.setTitle(nombre, for: .normal)
                                })
                                menuActions.append(action)
                            }
                        }
                        
                        let menu = UIMenu(title: "Selecciona una Institución", children: menuActions)
                        
                        DispatchQueue.main.async {
                            self.institucionOptions.showsMenuAsPrimaryAction = true
                            self.institucionOptions.menu = menu
                        }
                    } else {
                        print("No se encontraron datos de instituciones en la respuesta JSON")
                    }
                } else {
                    print("Respuesta no válida")
                }
            } catch {
                print("Error al analizar la respuesta JSON: \(error)")
            }
        }.resume()
    }

    
    func fetchPaisesFromEndpoint() {
        guard let url = URL(string: "http://127.0.0.1:8000/Paises/") else {
            print("URL inválida")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error al realizar la solicitud: \(error)")
                return
            }
            
            guard let data = data else {
                print("No se recibieron datos")
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    if let results = json["results"] as? [[String: String]] {
                        var menuActions: [UIAction] = []
                        
                        for item in results {
                            if let nombre = item["nombre"] {
                                let action = UIAction(title: nombre, handler: { [weak self] _ in
                                    self?.paisOptions.setTitle(nombre, for: .normal)
                                })
                                menuActions.append(action)
                            }
                        }
                        
                        let menu = UIMenu(title: "Selecciona un País", children: menuActions)
                        
                        DispatchQueue.main.async {
                            self.paisOptions.showsMenuAsPrimaryAction = true
                            self.paisOptions.menu = menu
                        }
                    } else {
                        print("No se encontraron datos de países en la respuesta JSON")
                    }
                } else {
                    print("Respuesta no válida")
                }
            } catch {
                print("Error al analizar la respuesta JSON: \(error)")
            }
        }.resume()
    }
    
    @IBAction func CrearCuentaTapped(_ sender: UIButton) {
        // Obtén los valores de los campos de texto y los botones
            guard let nombre = nombre.text,
                  let grado = gradoOptions.title(for: .normal),
                  let disciplina = disciplinaOptions.title(for: .normal),
                  let pais = paisOptions.title(for: .normal),
                  let institucion = institucionOptions.title(for: .normal),
                  let genero = generoOptions.title(for: .normal),
                  let correo = correo.text,
                  let username = username.text,
                  let password = password.text else {
                print("Debes completar todos los campos")
                return
            }

            // Crea un diccionario con los valores recopilados
            let usuarioData: [String: Any] = [
                "nombre": nombre,
                "grado": grado,
                "disciplina": disciplina,
                "pais": pais,
                "institucion": institucion,
                "genero": genero,
                "correo": correo,
                "username": username,
                "password": password
            ]

            // Convierte el diccionario a JSON
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: usuarioData, options: .prettyPrinted)
                
                // Ahora puedes enviar jsonData al servidor como solicitud POST
                
                // Define la URL del endpoint del servidor
                guard let url = URL(string: "http://127.0.0.1:8000/Usuarios/") else {
                    print("URL inválida")
                    return
                }

                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpBody = jsonData

                URLSession.shared.dataTask(with: request) { (data, response, error) in
                    if let error = error {
                        print("Error al realizar la solicitud: \(error)")
                        return
                    }

                    // Procesa la respuesta del servidor aquí si es necesario

                }.resume()
            } catch {
                print("Error al convertir los datos a JSON: \(error)")
            }

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
        
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
    }
    
    @IBAction func CheckBoxTapped(_ sender: UIButton) {
        if sender.isSelected{
            sender.isSelected = false
        }else{
            sender.isSelected = true
        }
    }
    
    func updateTextView(){
        let path = "https://tec.mx/es/aviso-de-privacidad-sel4c"
        let text = textView.text ?? ""
        let attributedString = NSAttributedString.makeHyperlink(for: path, in: text, as: "terminos y condiciones")
        textView.attributedText = attributedString
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
