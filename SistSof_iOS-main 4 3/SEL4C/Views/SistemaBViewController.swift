//
//  SistemaBViewController.swift
//  SEL4C
//
//  Created by Andrea Samantha Aguilar on 07/10/23.
//

import UIKit
import WebKit

class SistemaBViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadwebsite()
        // Do any additional setup after loading the view.
    }
    
    func loadwebsite() {
        guard let sistemaBURL = URL(string: " https://www.sistemab.org/directorio-b/") else { return }
        webView.load( URLRequest(url: sistemaBURL) )
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
