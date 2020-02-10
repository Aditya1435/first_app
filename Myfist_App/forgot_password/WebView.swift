//
//  WebView.swift
//  Myfist_App
//
//  Created by sonu on 12/12/19.
//  Copyright © 2019 sonu. All rights reserved.
//

import UIKit
import WebKit

    class WebView: UIViewController, WKNavigationDelegate , WKUIDelegate   {
    
    var activityIndicator = UIActivityIndicatorView()
    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
     
        activityIndicator.center = self.view.center
        webView.navigationDelegate = self
        webView.uiDelegate = self
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
              
        let url = URL(string: "https://www.google.co.in")
        let request = URLRequest(url: url!)
        webView.load(request)
     
    }
   
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        toolbarItems = [refresh]
        navigationController?.isToolbarHidden = false
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
    }
    
    @IBAction func web_back(_ sender: Any) {
         self.navigationController?.popViewController(animated: true)
    }
    
}
