import UIKit
import AVKit
import MobileCoreServices

class Actividad1ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIDocumentPickerDelegate {
    let imagePicker = UIImagePickerController()
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
        if let mediaURL = info[UIImagePickerController.InfoKey.mediaURL] as? URL {
               // Obtiene el nombre del archivo de la URL
               let fileName = mediaURL.lastPathComponent
               print("Nombre del archivo seleccionado: \(fileName)")
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    @IBAction func entregaButton(_ sender: Any) {
        Task {
               do {
                   try await crearProgreso()
                   
                   let storyboard = UIStoryboard(name: "Main", bundle: nil)
                   let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
                   (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
                   
               } catch {
                   print("No se pudo crear el usuario debido a errores de validación.")
               }
           }
       }

    func crearProgreso() async throws {
        // Obtén los valores de los campos de texto y los botones
        guard let filename = filename.text
        else {
            mostrarAlerta("Debes darle un título a tu entrega.")
            throw ValidationError.missingTitulo
        }
        
        if filename.isEmpty {
            mostrarAlerta("Debes darle un título a tu entrega.")
            throw ValidationError.missingTitulo
        }
        
        // Crea una instancia de Progreso con la URL completa
        let newProgreso = Progreso(
            usuario: 5,
            actividad: 1,
            titulo: filename,
            //file: fullURL?.absoluteString ?? "",
            completado: true
        )
        
        print(newProgreso)
        
        // Envía el nuevo Progreso al servidor
        do {
            try await progressCreationController.insertProgreso(newProgreso: newProgreso)
            print("Progreso creado exitosamente")
        } catch {
            print("Error al crear el Progreso: \(error)")
            throw ValidationError.progresoCreationFailed
        }
    }

    
    func mostrarAlerta(_ mensaje: String) {
         let alert = UIAlertController(title: "Error", message: mensaje, preferredStyle: .alert)
         alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
         present(alert, animated: true, completion: nil)
     }
    
    enum ValidationError: Error {
           case missingTitulo
           case progresoCreationFailed
        case fileReadFailed
    }

    
}
