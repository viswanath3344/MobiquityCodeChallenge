//
//  HelpViewController.swift
//  MobiquityCodeChallenge
//
//  Created by Apple on 28/02/21.
//

import UIKit
import WebKit

class HelpViewController: UIViewController,WKNavigationDelegate {

    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Help"
        
        if let url = Bundle.main.url(forResource: "Help", withExtension:"html"){
            webView.load(URLRequest(url: url))
            webView.allowsBackForwardNavigationGestures = true
        }
    
        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
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
