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
    
    @IBAction func loginTapped(_ sender: UIButton) {

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
        
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        // Do any additional setup after loading the view.
    }


}

