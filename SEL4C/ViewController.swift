//
//  ViewController.swift
//  SEL4C
//
//  Created by César Andrés Ceballos Castillo on 30/08/23.
//

import UIKit

class ViewController: UIViewController {

   /*
    @IBAction func inicioSesion(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ActividadesViewController") as! ActividadesViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
    */
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var MensajeError: UILabel!
    
    
    let userLoginController = UserLoginController()
    
    
    
    
    @IBAction func loginTapped(_ sender: UIButton) {
        guard let username = usernameTextField.text,
              let password = passwordTextField.text else {
            // Manejar el caso en el que los campos estén vacíos
            return
        }

        UserLoginController().login(username: username, password: password) { result in
            switch result {
            case .success(let response):
                // La solicitud POST fue exitosa, responseText contiene el texto de la respuesta
                
                
                DispatchQueue.main.async {
                    let respuesta = response.message
                    print("Esta es la respuesta aunque esté mal: \(respuesta)")
                    if respuesta == "Login exitoso"{
                        print("|"+response.message+"|")
                        self.MensajeError.isHidden = true
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
                        
                        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
                        
                    }else{
                        print("No Jaló:(")
                        self.MensajeError.isHidden = false
                    }
                    //self.Texto.text = responseText
                }
                
            case .failure(let error):
                // Manejar errores, por ejemplo, mostrar un mensaje de error
                print("Error en la solicitud POST: \(error.localizedDescription)")
            }
        }
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        // Do any additional setup after loading the view.
    }


}

