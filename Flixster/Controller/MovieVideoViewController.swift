//
//  MovieVideoViewController.swift
//  Flixster
//
//  Created by Julio Cesar Whatley on 10/20/19.
//  Copyright © 2019 Capi. All rights reserved.
//

import UIKit
import WebKit

class MovieVideoViewController: UIViewController, WKUIDelegate {

    @IBOutlet weak var webView: WKWebView!
    var videoUrl: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let myURL = URL(string: videoUrl)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
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
