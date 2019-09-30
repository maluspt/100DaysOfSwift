//
//  ViewController.swift
//  Milestone Project 2
//
//  Created by Maria Luiza Carvalho Sperotto on 27/09/19.
//  Copyright © 2019 Maria Luiza Carvalho Sperotto. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var shoppingList: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        title = "Lista de compras"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        navigationItem.rightBarButtonItem!.tintColor = UIColor.white
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteItems))
        navigationItem.leftBarButtonItem!.tintColor = UIColor.white
    }
    
    @objc func deleteItems() {
        shoppingList.removeAll(keepingCapacity: true)
        tableView.reloadData()
        
    }
    
    
    @objc func addItem() {
        let alert = UIAlertController(title: "Adicione um item", message: nil, preferredStyle: .alert)
        alert.addTextField()
        
        let submitItem = UIAlertAction(title: "OK", style: .default) { [weak self, weak alert] action in
            guard let item = alert?.textFields?[0].text else { return }
            self?.submit(item)
            
            
            
            
        }
        
        alert.addAction(submitItem)
        present(alert, animated: true)
        
    }
    
    func submit(_ item: String) {
        shoppingList.insert(item, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        
        
        }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
        
    }


}

