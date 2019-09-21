//
//  ViewController.swift
//  Milestone 1 Project
//
//  Created by Maria Luiza Carvalho Sperotto on 20/09/19.
//  Copyright © 2019 Maria Luiza Carvalho Sperotto. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var countries = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Flag Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true

    
        
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasSuffix(".png") {
                countries.append(item)
                
            }
        }
        
        countries = sortFlags(flags: countries)

    }
        
    
    

   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Country", for: indexPath)
            
        cell.textLabel?.text = getTextForFlag(flagName: countries[indexPath.row]).uppercased()
        cell.imageView?.image = UIImage(named: countries[indexPath.row])
    
        
        
        cell.imageView?.layer.borderColor = UIColor.black.cgColor
        cell.imageView?.layer.borderWidth = 0.1
        cell.imageView?.layer.cornerRadius = 0.5
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = countries[indexPath.row]
            
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
        
        
    }





