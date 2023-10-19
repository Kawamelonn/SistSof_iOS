//
//  RegistroViewController.swift
//  SEL4C
//
//  Created by César Andrés Ceballos Castillo on 30/08/23.
//

import UIKit

class RegistroViewController: UIViewController {
    @IBOutlet weak var nombre: UITextField!
    
    @IBOutlet weak var textView: UILabel!
    
    
    @IBOutlet weak var gradoOptions: UIButton!
    
    
    @IBOutlet weak var generoOptions: UIButton!
    
   
    @IBOutlet weak var disciplinaOptions: UIButton!
   
    @IBOutlet weak var username: UITextField!
  
    @IBOutlet weak var mailUsuario:UITextField!
 
    @IBOutlet weak var password:UITextField!
    
    @IBOutlet weak var repassword:UITextField!
    
    @IBOutlet weak var institucionesOptions: UIButton!
    
    @IBOutlet weak var paisOptions: UIButton!
    
    @IBOutlet weak var acceptTerms: UIButton!
    
    
    var userCreationController = UserCreationController()
    var selectedInstitucionID: Int?
    var selectedPaisID: Int?

    override func viewDidLoad() {
          super.viewDidLoad()
         
        Task{
            do {
                let allInstituciones = try await fetchAllInstituciones()
                updateUIIn(with: allInstituciones)
            } catch {
                print("Error al obtener todas las instituciones: \(error)")
            }
        }
        Task{
            do {
                let allPaises = try await fetchAllPaises()
                updateUIPa(with: allPaises)
            } catch {
                print("Error al obtener todos los paises: \(error)")
            }
        }
          setPullDown()
          optionsGenero()
          optionsDisciplina()
          // Agrega un gesto de toque a textView
              let tapGesture = UITapGestureRecognizer(target: self, action: #selector(abrirEnlace))
              textView.isUserInteractionEnabled = true
              textView.addGestureRecognizer(tapGesture)
      }
     
      func fetchAllInstituciones() async -> [Institucion] {
          var allInstituciones: [Institucion] = []
          var currentPage = 1

          while true {
              do {
                  let instituciones = try await Institucion.fetchInstituciones(page: currentPage)

                  if instituciones.results.isEmpty {
                      // No hay más resultados, sal del bucle
                      break
                  }

                  allInstituciones.append(contentsOf: instituciones.results)
                  currentPage += 1
              } catch {
                  print("Error al obtener datos de la página \(currentPage): \(error)")
                  break // En caso de error, sal del bucle
              }
          }
         
          return allInstituciones
      }
     
      func updateUIIn(with instituciones: [Institucion]) {
          var menuActions: [UIAction] = []

          for institucion in instituciones{
              let action = UIAction(title: institucion.nombre, handler: { [weak self] _ in
                  self?.institucionesOptions.setTitle(institucion.nombre, for: .normal)
                  self?.selectedInstitucionID = institucion.id
              })
              menuActions.append(action)
          }

          let menu = UIMenu(title: "Selecciona una Institución", children: menuActions)

          DispatchQueue.main.async {
              self.institucionesOptions.showsMenuAsPrimaryAction = true
              self.institucionesOptions.menu = menu
          }
      }
     
      func fetchAllPaises() async -> [Pais] {
          var allPaises: [Pais] = []
          var currentPage = 1

          while true {
              do {
                  let paises = try await Pais.fetchPaises(page: currentPage)

                  if paises.results.isEmpty {
                      // No hay más resultados, sal del bucle
                      break
                  }

                  allPaises.append(contentsOf: paises.results)
                  currentPage += 1
              } catch {
                  print("Error al obtener datos de la página \(currentPage): \(error)")
                  break // En caso de error, sal del bucle
              }
          }
         
          return allPaises
      }


      func updateUIPa(with paises: [Pais]) {
          var menuActions: [UIAction] = []

          for pais in paises {
              let action = UIAction(title: pais.nombre, handler: { [weak self] _ in
                  self?.paisOptions.setTitle(pais.nombre, for: .normal)
                  self?.selectedPaisID = pais.id
              })
              menuActions.append(action)
          }

          let menu = UIMenu(title: "Selecciona un País", children: menuActions)

          DispatchQueue.main.async {
              self.paisOptions.showsMenuAsPrimaryAction = true
              self.paisOptions.menu = menu
          }
      }

     
      func displayError(_ error: Error, title: String) {
          DispatchQueue.main.async {
              let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
              alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
              self.present(alert, animated: true, completion: nil)
          }
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
     
      @IBAction func CrearCuentaTapped(_ sender: UIButton) {
          Task {
                 do {
                     try await crearUsuario()
                     
                     let storyboard = UIStoryboard(name: "Main", bundle: nil)
                     let mainTabBarController = storyboard.instantiateViewController(identifier: "LoginNavigationController")
                     (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
                     
                 } catch {
                     print("No se pudo crear el usuario debido a errores de validación.")
                 }
             }
         }

         func crearUsuario() async throws {
             // Obtén los valores de los campos de texto y los botones
             guard let nombre = nombre.text,
                   let genero = generoOptions.title(for: .normal),
                   let grado = gradoOptions.title(for: .normal),
                   let disciplina = disciplinaOptions.title(for: .normal),
                   let correo = mailUsuario.text,
                   let username = username.text,
                   let password = password.text,
                   let contraseña = repassword.text
             else {
                 mostrarAlerta("Completar todos los campos")
                 throw ValidationError.missingFields
             }
             
             if !acceptTerms.isSelected {
                 mostrarAlerta("Debes aceptar los términos y condiciones para continuar.")
                 throw ValidationError.termsNotAccepted
             }
             
             if nombre.isEmpty {
                   mostrarAlerta("Debes agregar tu nombre completo.")
                   throw ValidationError.emptyNombre
               }
             
             if correo.isEmpty {
                   mostrarAlerta("El correo no puede estar en blanco.")
                   throw ValidationError.emptyCorreo
               }
             
             if username.isEmpty {
                   mostrarAlerta("El nombre de usuario no pueden ser nulo.")
                   throw ValidationError.emptyUsername
               }
             
             if password.isEmpty || contraseña.isEmpty {
                   mostrarAlerta("Las contraseñas no pueden estar en blanco.")
                   throw ValidationError.emptyPasswords
               }

             if password != contraseña {
                 mostrarAlerta("Las contraseñas no coinciden. Por favor, asegúrate de que las contraseñas sean iguales.")
                 throw ValidationError.passwordMismatch
             }
             if let selectedInID = selectedInstitucionID, let selectedPaID = selectedPaisID {
                 // Crea un objeto Usuario con los datos recopilados
                let newUsuario = Usuario(
                        nombre: nombre,
                        genero: genero,
                        grado: grado,
                        disciplina: disciplina,
                        pais: selectedPaID,
                        institucion: selectedInID,
                        correo: correo,
                        username: username,
                        password: password
                 )
                 print(newUsuario)
                 
                 // Envía el nuevo usuario a la base de datos
                 do {
                     try await userCreationController.insertUser(newUsuario: newUsuario)
                     print("Usuario creado exitosamente")
                 } catch {
                     print("Error al crear el usuario: \(error)")
                     throw ValidationError.userCreationFailed
                 }
             } else {
                 // Manejar el caso en el que no hay una institución seleccionada
                 print("No se ha seleccionado una institución.")
                 // Aquí puedes mostrar una alerta o tomar alguna otra acción apropiada
             }

          }

      func mostrarAlerta(_ mensaje: String) {
           let alert = UIAlertController(title: "Error", message: mensaje, preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
           present(alert, animated: true, completion: nil)
       }
     
         enum ValidationError: Error {
             case missingFields
             case termsNotAccepted
             case emptyNombre
             case emptyCorreo
             case emptyUsername
             case emptyPasswords
             case passwordMismatch
             case userCreationFailed
         }
     
      @IBAction func CheckBoxTapped(_ sender: UIButton) {
          if sender.isSelected{
              sender.isSelected = false
          }else{
              sender.isSelected = true
          }
      }
     
      @objc func abrirEnlace() {
          if let url = URL(string: "https://tec.mx/es/aviso-de-privacidad-sel4c") {
              UIApplication.shared.open(url, options: [:], completionHandler: nil)
          }
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


