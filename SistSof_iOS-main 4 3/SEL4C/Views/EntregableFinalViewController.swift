//
//  EntregableFinalViewController.swift
//  SEL4C
//
//  Created by Andrea Samantha Aguilar on 08/10/23.
//

import UIKit
import AVKit
import MobileCoreServices

class EntregableFinalViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imagePickerController = UIImagePickerController()
    var videoURL: URL?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tap(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            
             print("Camera Available")

            let videoPicker = UIImagePickerController()
            videoPicker.delegate = self
            videoPicker.sourceType = .camera
            videoPicker.mediaTypes = [kUTTypeMovie as String] // MobileCoreServices
            videoPicker.allowsEditing = false

             self.present(videoPicker, animated: true, completion: nil)
            
         }else{
             
             print("Camera UnAvaialable")
         }
    }
    
    //MARK:- UINavigationControllerDelegate
    
    var myPickedVideo:NSURL! = NSURL()
    
    var VideoToPass:Data!

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // Close
        dismiss(animated: true, completion: nil)

        guard
            let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String,
            mediaType == (kUTTypeMovie as String),
            let url = info[UIImagePickerController.InfoKey.mediaURL] as? URL,
            UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(url.path)
            
            else {
                return
            }
        
        
        if let pickedVideo:NSURL = (info[UIImagePickerController.InfoKey.mediaURL] as? NSURL) {

            // Get Video URL
            self.myPickedVideo = pickedVideo
            
            do {
                try? VideoToPass = Data(contentsOf: pickedVideo as URL)
                let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
                let documentsDirectory = paths[0]
                let tempPath = documentsDirectory.appendingFormat("/vid.mp4")
                let url = URL(fileURLWithPath: tempPath)
                do {
                    try? VideoToPass.write(to: url, options: [])
                }

                // If you want display Video here 1
            }
        }
        // Handle a movie capture
         UISaveVideoAtPathToSavedPhotosAlbum(
             url.path,
             self,
            #selector(video(_:didFinishSavingWithError:contextInfo:)),
             nil)
    }
    
    @objc func video(_ videoPath: String, didFinishSavingWithError error: Error?, contextInfo info: AnyObject) {
        
        let title = (error == nil) ? "Bien" : "Error"
        let message = (error == nil) ? "El video fue guardado" : "El video no se guardó"

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
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


