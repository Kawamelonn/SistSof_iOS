//
//  ActividadesViewController.swift
//  SEL4C
//
//  Created by César Andrés Ceballos Castillo on 31/08/23.
//

import UIKit

class ActividadesViewController: UIViewController{

    var temp: String = ":("
    var temp1: Bool = false
    
    @IBOutlet weak var CuadroActividadGrande: UIImageView!
    
    @IBOutlet weak var CuadroActividadMediano: UIImageView!
    
    
    @IBOutlet weak var BotonIniciar: UIButton!
    
    @IBOutlet weak var LabelActividad: UILabel!
    
    @IBOutlet weak var Completado: UILabel!
    
    @IBOutlet weak var CuadroActividadChico: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        print (temp)
        print(temp1)
        if(temp1 == true){
            CuadroActividadMediano.image = UIImage(named: "CuadradoVerdeObscuro")
            CuadroActividadGrande.image = UIImage(named: "CuadroVerdeReal")
            BotonIniciar.isHidden = true
            CuadroActividadChico.isHidden = false
            Completado.isHidden = false
            
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)

        // Do any additional setup after loading the view.
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
