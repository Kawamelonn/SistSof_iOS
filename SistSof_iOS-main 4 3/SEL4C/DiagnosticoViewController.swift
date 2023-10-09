//
//  DiagnosticoViewController.swift
//  SEL4C
//
//  Created by César Andrés Ceballos Castillo on 05/09/23.
//

import UIKit

class DiagnosticoViewController: UIViewController {

    var entregado = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //func entregadoSi() -> Bool{
        
    //}
    
    func imprimirEntregado(){
        print("Completado")
        print (entregado)
    }
    
    @IBAction func Entregar(_ sender: Any) {
        imprimirEntregado()
        entregado = true
        imprimirEntregado()
    
    }
    
    func getEntregado() -> Bool{
        return (entregado)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        let entregadoVerdad = getEntregado()
        
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
