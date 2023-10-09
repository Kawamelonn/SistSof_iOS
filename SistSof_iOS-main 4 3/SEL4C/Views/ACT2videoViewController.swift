//
//  ACT2videoViewController.swift
//  SEL4C
//
//  Created by Andrea Samantha Aguilar on 08/10/23.
//

import UIKit
import WebKit

class ACT2videoViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadYoutube()
        // Do any additional setup after loading the view.
    }
    func loadYoutube() {
        guard let youtubeURL = URL(string: "https://youtu.be/MCKH5xk8X-g.") else { return }
        webView.load( URLRequest(url: youtubeURL) )
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
