//
//  WebViewController.swift
//  Project16
//
//  Created by Maria Luiza Carvalho Sperotto on 29/10/19.
//  Copyright © 2019 Maria Luiza Carvalho Sperotto. All rights reserved.
//

import WebKit
import UIKit

class WebViewController: UIViewController {
    @IBOutlet var webView: WKWebView!
    
    var website: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard website != nil else {
            print("Website not set")
            navigationController?.popViewController(animated: true)
            return
        }
        if let url = URL(string: website) {
            webView.load(URLRequest(url: url))
        }
    }
}
