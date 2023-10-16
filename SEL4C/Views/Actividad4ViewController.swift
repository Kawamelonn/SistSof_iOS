//
//  Actividad4ViewController.swift
//  SEL4C
//
//  Created by Andrea Samantha Aguilar on 11/10/23.
//

import UIKit

class Actividad4ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagePicker = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tap(_ sender: Any) {
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
                    // Handle the picked image here
                    //imagen.image = pickedImage
                }
                picker.dismiss(animated: true, completion: nil)
            }

            func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
                picker.dismiss(animated: true, completion: nil)
            }
}

