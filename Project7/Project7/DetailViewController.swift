//
//  DetailViewController.swift
//  Project7
//
//  Created by Maria Luiza Carvalho Sperotto on 30/09/19.
//  Copyright © 2019 Maria Luiza Carvalho Sperotto. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    var webView: WKWebView!
    var detailItem: Petition?
    
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let detailItem = detailItem else { return }
        let html = """
        <html>
        <head>
        <meta name="viewport" content="width=devide-width, initial-scale=1">
        <meta charset="UTF-8">
        <style> body {
            font-size: 150%;
        }
        
        </style>
        </head>
        <body>
        <h2><b>\(detailItem.title)</b></h2>
        <p>\(detailItem.body)</p>
        </body>
        </html>
        """
        
        
        webView.loadHTMLString(html, baseURL: nil)

        // Do any additional setup after loading the view.
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
