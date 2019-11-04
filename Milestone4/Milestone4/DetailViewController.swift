//
//  DetailViewController.swift
//  Milestone4
//
//  Created by Maria Luiza Carvalho Sperotto on 28/10/19.
//  Copyright © 2019 Maria Luiza Carvalho Sperotto. All rights reserved.
//

import UIKit


class DetailViewController: UIViewController {
    var country: Country?
    
    

    
    @IBOutlet weak var capitalLabel: UILabel!
    @IBOutlet weak var popLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var demonymLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let pop = country?.population else { return }
        guard let capital = country?.capital else { return }
        guard let demonym = country?.demonym else { return }

        nameLabel.text = country?.name
        popLabel.text = "População: \(pop)"
        capitalLabel.text = "Capital: \(capital)"
        demonymLabel.text = "Nacionalidade: \(demonym)"
        
    }
    
  
    
    

        }
    

    




