//
//  DesempenoViewController.swift
//  SEL4C
//
//  Created by Margarita Mendoza on 17/10/23.
//

import UIKit

class DesempenoViewController: UIViewController {

    @IBOutlet weak var autocontrolini: UILabel!
    
    @IBOutlet weak var liderazgoini: UILabel!
    
    @IBOutlet weak var concienciaini: UILabel!
    
    @IBOutlet weak var innovacionini: UILabel!
    
    @IBOutlet weak var sistematicoini: UILabel!
    
    @IBOutlet weak var cientificoini: UILabel!
    
    @IBOutlet weak var criticoini: UILabel!
    
    @IBOutlet weak var innovadorini: UILabel!
    
    @IBOutlet weak var autocontrolfinal: UILabel!
    
    @IBOutlet weak var liderazgofinal: UILabel!
    
    @IBOutlet weak var concienciafinal: UILabel!
    
    @IBOutlet weak var innovacionfinal: UILabel!
    
    @IBOutlet weak var sistematicofinal: UILabel!
    
    @IBOutlet weak var cientificofinal: UILabel!
    
    @IBOutlet weak var criticofinal: UILabel!
    
    @IBOutlet weak var innovadorfinal: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            do{
                if let userIdPrueba = UserDefaults.standard.string(forKey: "UserId"), let userId = Int(userIdPrueba) {
                    let datos = try await DesempeñoData.fetchDesempeñoData(id: userId)
                    print(datos)
                    updateUI(with: datos)
                } else {
                    print("No hay ID")
                }
            }
        }
    }
    
    func updateUI(with datos:DesempeñoData){
        DispatchQueue.main.async {
            self.autocontrolini.text = datos.autocontrolini
            self.liderazgoini.text = datos.liderazgoini
            self.concienciaini.text = datos.concienciaini
            self.innovacionini.text = datos.innovacionini
            self.sistematicoini.text = datos.sistemicoini
            self.cientificoini.text = datos.cientificoini
            self.criticoini.text = datos.criticoini
            self.innovadorini.text = datos.innovadorini
            
            self.autocontrolfinal.text = datos.autocontrolfin
            self.liderazgofinal.text = datos.liderazgofin
            self.concienciafinal.text = datos.concienciafin
            self.innovacionfinal.text = datos.innovacionfin
            self.sistematicofinal.text = datos.sistemicofin
            self.cientificofinal.text = datos.cientificofin
            self.criticofinal.text = datos.criticofin
            self.innovadorfinal.text = datos.innovadorfin
            
        }
    }
}
