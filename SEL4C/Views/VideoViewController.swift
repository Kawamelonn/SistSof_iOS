//
//  VideoViewController.swift
//  SEL4C
//
//  Created by Usuario on 09/10/23.
//

import UIKit
import WebKit

class VideoViewController: UIViewController {

    @IBOutlet var webView: WKWebView!
    
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
