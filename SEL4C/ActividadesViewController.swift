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
    
    
    @IBOutlet weak var MiVistaDiagnostico1: UIView!
    
    @IBOutlet weak var MiVistaMalaDiagnostico1: UIView!
    
    
    
    @IBOutlet weak var MiVista1: UIView!
    
    @IBOutlet weak var MiVistaMala1: UIView!
    
    
    @IBOutlet weak var MiVistaBloqueada1: UIView!
    
    @IBOutlet weak var MiVista2: UIView!
    
    @IBOutlet weak var MiVistaMala2: UIView!
    
    @IBOutlet weak var MiVistaBloqueada2: UIView!
    
    @IBOutlet weak var MiVista3: UIView!
    
    @IBOutlet weak var MiVistaMala3: UIView!
    
    @IBOutlet weak var MiVistaBloqueada3: UIView!
    
    @IBOutlet weak var MiVista4: UIView!
    
    @IBOutlet weak var MiVistaMala4: UIView!
    
    @IBOutlet weak var MiVistaBloqueada4: UIView!
    
    @IBOutlet weak var MiVista5: UIView!
    
    @IBOutlet weak var MiVistaMala5: UIView!
    
    @IBOutlet weak var MiVistaBloqueada5: UIView!
    
    @IBOutlet weak var MiVista6: UIView!
    
    @IBOutlet weak var MiVistaMala6: UIView!
    
    @IBOutlet weak var MiVistaBloqueada6: UIView!
    
    
    
    
    
    
    
    
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
    
    var engine = EcomplexityEngine()

    override func viewDidLoad() {
        
        //let id = 1//UserDefaults.standard.string(forKey: "UserId")


        //MiVistaBloqueada.isHidden = true
        Task{
            do{if let userIdPrueba = UserDefaults.standard.string(forKey: "UserId"), let userId = Int(userIdPrueba) {
                let actividades = try await Actividad.fetchQuestions(usuario: userId)
                let autodiagnosticos = try await Autodiagnostico.fetchAutodiagnostico(usuario: userId, num_aut: 1)
                //print("diagnostico 1: \(engine.getAutoStatus())")
                let autodiagnosticos2 = try await Autodiagnostico.fetchAutodiagnostico(usuario: userId, num_aut: 2)
                //print("diagnostico 2: \(engine.getAutoStatus())")
                
                self.updateUI(with: actividades, autodiagnosticos:autodiagnosticos, autodiagnosticos2:autodiagnosticos2)
            } else {
                print("No hay ID")
            }
                
                //updateUI(with: actividades)
            }catch{
                displayError(ActividadError.itemNotFound, title: "No se pudo acceder a las actividades")
            }
        }
        let completada = engine.getStatus()
        
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        }
    
    func updateUI(with actividades:Actividades, autodiagnosticos:Autodiagnosticos, autodiagnosticos2:Autodiagnosticos){
        engine.initialize(q: actividades)
        engine.initializeAuto(qq: autodiagnosticos)
        print("diagnostico 1: \(engine.getAutoStatus())")
        
        let idAuto = engine.getAutoId()
        let completadoAuto1 = engine.getAutoStatus()
        let autoVC = Autodiagnostico(usuario_id: idAuto, preguntaFinalCompletada: completadoAuto1)
        
        
                let id = engine.getID()
                let completado1 = engine.getStatus()
                
                // Creación de la instancia de Actividad con valores obtenidos
                let actividadVC = Actividad(id: id, completado: completado1)
                print(actividadVC)
                // Actualización de la interfaz de usuario con valores obtenidos
                DispatchQueue.main.async {
                    //var textov = "falsa"
                    if completadoAuto1{
                        self.MiVistaDiagnostico1.isHidden = false
                        self.MiVistaMalaDiagnostico1.isHidden = true
                    }
                    
                    if completadoAuto1 == false{
                        self.MiVista1.isHidden = true
                        self.MiVistaMala1.isHidden = true
                        self.MiVistaBloqueada1.isHidden = false
                    }
                    
                    if completado1 {
                        //textov = "completada"
                        self.MiVista1.isHidden = false
                        self.MiVistaMala1.isHidden = true
                    }
                    
                    //self.texto.text = textov
                    
                    var hay = self.engine.nextQuestion()
                    let completado2 = self.engine.getStatus()
                    
                    if completado1 == false{
                        self.MiVista2.isHidden = true
                        self.MiVistaMala2.isHidden = true
                        self.MiVistaBloqueada2.isHidden = false
                        
                    }else{
                        self.MiVistaBloqueada2.isHidden = true
                        self.MiVistaMala2.isHidden = false
                        print("Actividad 1 completada")
                        //var textovv = "falsa"
                        
                        let idd = self.engine.getID()
                        if completado2 {
                            //textovv = "completada"
                            self.MiVista2.isHidden = false
                            self.MiVistaMala2.isHidden = true
                            print("actividad2 ?: \(idd)")
                        }
                        //self.textoA2.text = textovv
                    }
                    
                    hay = self.engine.nextQuestion()
                    let completado3 = self.engine.getStatus()
                    
                    if completado2 == false{
                        self.MiVista3.isHidden = true
                        self.MiVistaMala3.isHidden = true
                        self.MiVistaBloqueada3.isHidden = false
                        
                    }else{
                        self.MiVistaBloqueada3.isHidden = true
                        self.MiVistaMala3.isHidden = false
                        print("Actividad 1 completada")
                        //var textovv = "falsa"
                        let idd = self.engine.getID()
                        if completado3 {
                            //textovv = "completada"
                            self.MiVista3.isHidden = false
                            self.MiVistaMala3.isHidden = true
                            print("actividad3 ?: \(idd)")
                        }
                        //self.textoA2.text = textovv
                    }
                    
                    hay = self.engine.nextQuestion()
                    let completado4 = self.engine.getStatus()
                    
                    if completado3 == false{
                        self.MiVista4.isHidden = true
                        self.MiVistaMala4.isHidden = true
                        self.MiVistaBloqueada4.isHidden = false
                        
                    }else{
                        self.MiVistaBloqueada4.isHidden = true
                        self.MiVistaMala4.isHidden = false
                        print("Actividad 3 completada")
                        //var textovv = "falsa"
                        let idd = self.engine.getID()
                        if completado4 {
                            //textovv = "completada"
                            self.MiVista4.isHidden = false
                            self.MiVistaMala4.isHidden = true
                            print("actividad4 ?: \(idd)")
                        }
                        //self.textoA2.text = textovv
                    }
                    
                    hay = self.engine.nextQuestion()
                    let completado5 = self.engine.getStatus()
                    
                    if completado4 == false{
                        self.MiVista5.isHidden = true
                        self.MiVistaMala5.isHidden = true
                        self.MiVistaBloqueada5.isHidden = false
                        
                    }else{
                        self.MiVistaBloqueada5.isHidden = true
                        self.MiVistaMala5.isHidden = false
                        print("Actividad 4 completada")
                        //var textovv = "falsa"
                        let idd = self.engine.getID()
                        if completado5 {
                            //textovv = "completada"
                            self.MiVista5.isHidden = false
                            self.MiVistaMala5.isHidden = true
                            print("actividad5 ?: \(idd)")
                        }
                        //self.textoA2.text = textovv
                    }
                    
                    hay = self.engine.nextQuestion()
                    let completado6 = self.engine.getStatus()
                    
                    if completado5 == false{
                        self.MiVista6.isHidden = true
                        self.MiVistaMala6.isHidden = true
                        self.MiVistaBloqueada6.isHidden = false
                        
                    }else{
                        self.MiVistaBloqueada6.isHidden = true
                        self.MiVistaMala6.isHidden = false
                        print("Actividad 5 completada")
                        //var textovv = "falsa"
                        let idd = self.engine.getID()
                        if completado6 {
                            //textovv = "completada"
                            self.MiVista6.isHidden = false
                            self.MiVistaMala6.isHidden = true
                            print("actividad6 ?: \(idd)")
                        }
                        //self.textoA2.text = textovv
                    }
                    
                    
                    
                    
                    
                }
    }
    
    
    
    func displayError(_ error: Error, title: String) {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
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

}
