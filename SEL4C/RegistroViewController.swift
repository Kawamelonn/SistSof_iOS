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
    
    var userCreationController = UserCreationController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task{
            do{
                let instituciones = try await Institucion.fetchInstituciones()
                print(instituciones)
                updateUI(with: instituciones)
            }catch{
                displayError(InstitucionError.itemNotFound, title: "No se pudo accer a las instituciones")
            }
        }
        
        Task{
            do{
                let paises = try await Pais.fetchPaises()
                print(paises)
                updateUI(with: paises)
            }catch{
                displayError(PaisError.itemNotFound, title: "No se pudo accer a los paises")
            }
        }
        
        updateTextView()
        setPullDown()
        optionsGenero()
        optionsDisciplina()

    }
    
    func updateUI(with instituciones: Instituciones) {
        var menuActions: [UIAction] = []

        for institucion in instituciones.results {
            let action = UIAction(title: institucion.nombre, handler: { [weak self] _ in
                self?.institucionOptions.setTitle(institucion.nombre, for: .normal)
            })
            menuActions.append(action)
        }

        let menu = UIMenu(title: "Selecciona una Institución", children: menuActions)

        DispatchQueue.main.async {
            self.institucionOptions.showsMenuAsPrimaryAction = true
            self.institucionOptions.menu = menu
        }
    }
    
    func updateUI(with paises: Paises) {
        var menuActions: [UIAction] = []

        for pais in paises.results {
            let action = UIAction(title: pais.nombre, handler: { [weak self] _ in
                self?.paisOptions.setTitle(pais.nombre, for: .normal)
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
        
        Task{
            await crearUsuario()
        }
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
            
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
        }
    
    func crearUsuario() async {
        // Obtén los valores de los campos de texto y los botones
            guard let nombre = nombre.text,
                  let grado = gradoOptions.title(for: .normal),
                  let disciplina = disciplinaOptions.title(for: .normal),
                  let genero = generoOptions.title(for: .normal),
                  let correo = correo.text,
                  let username = username.text,
                  let password = password.text else {
                print("Debes completar todos los campos")
                return
            }

            // Crea un objeto Usuario con los datos recopilados
            let newUsuario = Usuario(
                nombre: nombre,
                grado: grado,
                disciplina: disciplina,
                genero: genero,
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
        }
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
