//
//  RegistroViewController.swift
//  SEL4C
//
//  Created by César Andrés Ceballos Castillo on 30/08/23.
//

import UIKit

class RegistroViewController: UIViewController {

    
    @IBOutlet weak var textView: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTextView()

        // Do any additional setup after loading the view.
    }
    @IBAction func CrearCuentaTapped(_ sender: UIButton) {

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
