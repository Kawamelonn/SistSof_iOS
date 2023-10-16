//
//  PerfilViewController.swift
//  SEL4C
//
//  Created by César Andrés Ceballos Castillo on 01/09/23.
//

import UIKit



class PerfilViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    
    @IBOutlet weak var NombreLabel: UILabel!
    
    
    @IBOutlet weak var CorreoLabel: UILabel!
    
    @IBOutlet weak var UsuarioLabel: UILabel!
    
    
    
    
    
    
    var engine = EcomplexityEngine()
    
    @IBOutlet weak var imagen: UIImageView!
    let imagePicker = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        // Do any additional setup after loading the view.
    }
    @IBAction func seleccionarimagen(_ sender: UIButton) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true)
    }
    
    @IBAction func logoutTapped(_ sender: UIButton) {
    
    // ...
            // Para salir
      
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginNavController = storyboard.instantiateViewController(identifier: "LoginNavigationController")

        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(loginNavController)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imagen.image = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        Task{
            do{if let userIdPrueba = UserDefaults.standard.string(forKey: "UserId"), let userId = Int(userIdPrueba) {
                let perfiles = try await Perfil.fetchPerfiles(id_usuario: userId)
                self.updateUI(with: perfiles)
                
                
                }
                
            }
        }
    }
    
    func updateUI(with perfiles: Perfiles){
        engine.initializePerfil(qqq: perfiles)
        
        self.NombreLabel.text = self.engine.getNombre()
        self.UsuarioLabel.text = self.engine.getUsuario()
        self.CorreoLabel.text = self.engine.getCorreo()
        
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
