//
//  DetailViewController.swift
//  Milestone 1 Project
//
//  Created by Maria Luiza Carvalho Sperotto on 20/09/19.
//  Copyright © 2019 Maria Luiza Carvalho Sperotto. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    
    
    var selectedImage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        title = getTextForFlag(flagName: selectedImage!).uppercased()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareFlag))


        
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
            
        }

        
    }
    @objc func shareFlag() {
        guard let image = imageView.image?.jpegData(compressionQuality: 1) else {
            print("No image found")
            return
        }
        
        let vc = UIActivityViewController(activityItems: [title ?? "Unknown country", image], applicationActivities: [])
        
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        present(vc, animated: true)
    }
    
    

    

}
