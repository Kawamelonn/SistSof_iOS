//
//  sustainableViewController.swift
//  SEL4C
//
//  Created by Andrea Samantha Aguilar on 08/10/23.
//

import UIKit
import WebKit

class sustainableViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWeb()
        // Do any additional setup after loading the view.
    }
    func loadWeb() {
        guard let WebURL = URL(string: "https://www.undp.org/es/sustainable-development-goals") else { return }
        webView.load( URLRequest(url: WebURL) )
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
