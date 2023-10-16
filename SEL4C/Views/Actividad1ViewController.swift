//
//  Actividad1ViewController.swift
//  SEL4C
//
//  Created by Andrea Samantha Aguilar on 08/10/23.
//

import UIKit
import AVKit
import MobileCoreServices
import SwiftUI

class Actividad1ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIDocumentPickerDelegate {
    let imagePicker = UIImagePickerController()
    
    var engine = EcomplexityEngine()
    
    @IBOutlet weak var filename: UITextField!
    
    @IBOutlet weak var imagen: UIImageView!
    var progressCreationController = ProgressCreationController()
    var selectedUsuarioID: Int?
    var selectedActividadID: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
    }
    
    
    @IBAction func options(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Cámara", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Galería", style: .default, handler: { _ in
            self.openGallery()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancelar", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            present(imagePicker, animated: true, completion: nil)
        } else {
            // Handle the case where camera is not available (e.g., on simulator)
            print("Camera not available")
        }
    }
    
    func openGallery() {
            imagePicker.sourceType = .photoLibrary
            present(imagePicker, animated: true, completion: nil)
        }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                imagen.image = pickedImage
            }
            picker.dismiss(animated: true, completion: nil)
        }

    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func entregaButton(_ sender: Any) {
        if let pickedImage = imagen.image,
                 let fileName = filename.text?.trimmingCharacters(in: .whitespacesAndNewlines),
                 !fileName.isEmpty {
                    print("Activity: Actividad1")
                    print("Filename: \(fileName)")
                  Task {
                      do {
                          if let userIdPrueba = UserDefaults.standard.string(forKey: "UserId"),
                             let userId = Int(userIdPrueba) {
                              let user_id = userId
                              let perfiles = try await Perfil.fetchPerfiles(id_usuario: user_id)
                              engine.initializePerfil(qqq: perfiles)
                              let user = engine.getUsuario()
                              print("User: \(user)")
                              if let imageData = pickedImage.pngData() {
                                  _ = try await MultipartRequest.sendImage(user:user, activity: "Actividad1", evidence_name: fileName, fileData: imageData)
                                  print("Imagen enviada exitosamente")
                              } else {
                                  print("Error al convertir la imagen a datos")
                              }
                          }
                      } catch {
                          print("Error al enviar la imagen: \(error)")
                      }
                  }
              } else {
                  print("El nombre del archivo no puede estar vacío y se necesita una imagen seleccionada.")
              }
          }
      }
        
    
    //func displayError(_ error: Error, title: String) {
            //DispatchQueue.main.async {
                //let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
                //alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                //self.present(alert, animated: true, completion: nil)
            //}
        //}
    
//}
