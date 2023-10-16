//
//  SustainableViewController.swift
//  SEL4C
//
//  Created by Usuario on 09/10/23.
//

import UIKit
import WebKit

class SustainableViewController: UIViewController {
    
    @IBOutlet var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWeb()
        // Do any additional setup after loading the view.
    }
    func loadWeb() {
        guard let WebURL = URL(string: "https://www.undp.org/es/sustainable-development-goals") else { return }
        webView.load( URLRequest(url: WebURL) )
    }
}
