//
//  AshokaViewController.swift
//  SEL4C
//
//  Created by Andrea Samantha Aguilar on 07/10/23.
//

import UIKit
import WebKit

class AshokaViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadwebsite()
        // Do any additional setup after loading the view.
    }
    
    func loadwebsite() {
        guard let ashokaURL = URL(string: "https://www.ashoka.org/en-us/our-network") else { return }
        webView.load( URLRequest(url: ashokaURL) )
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
