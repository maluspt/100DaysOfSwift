//
//  WebViewController.swift
//  Project4
//
//  Created by Maria Luiza Carvalho Sperotto on 24/09/19.
//  Copyright © 2019 Maria Luiza Carvalho Sperotto. All rights reserved.
//
import WebKit
import UIKit


class WebViewController: UITableViewController {
    var websites = ["apple.com", "hackingwithswift.com"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Web pages"

        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Website", for: indexPath)
        cell.textLabel?.text = websites[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        
        vc.websites = websites
        vc.currentWebsite = indexPath.row
        
        navigationController?.pushViewController(vc, animated: true)
        
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
