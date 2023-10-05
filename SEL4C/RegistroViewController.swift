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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTextView()
        setPullDown()
        optionsGenero()
        optionsDisciplina()

        // Do any additional setup after loading the view.
    }
    @IBAction func CrearCuentaTapped(_ sender: UIButton) {
        let nombreCompleto = nombre.text
        let correo = mailUsuario.text
        let usuario = username.text
        let contrasena = password.text
        let confirmar_contrasena = repassword.text
        
        if (correo.isEmpty || usuario.isEmpty || nombreCompleto.isEmpty ){
            
            displayAlertMessage("Favor de completar el registro")
        }
        if (contrasena != confirmar_contrasena){
            displayAlertMesssage("Las contraseñas no coinciden")
        }
        
        func displayAlertMessage (userMessage: String ){
            var myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertController.Style);
            
        }

        //let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
        
        //(UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
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
