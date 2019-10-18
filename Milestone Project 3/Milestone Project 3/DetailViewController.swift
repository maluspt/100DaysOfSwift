//
//  DetailViewController.swift
//  Milestone Project 3
//
//  Created by Maria Luiza Carvalho Sperotto on 17/10/19.
//  Copyright © 2019 Maria Luiza Carvalho Sperotto. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    
    var selectedPhoto: Photo!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let image =  selectedPhoto.image
        
        imageView.image = UIImage(named: image)
        
        }
        
    


    }
    

   
    


