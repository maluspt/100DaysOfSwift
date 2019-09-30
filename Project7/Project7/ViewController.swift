//
//  ViewController.swift
//  Project7
//
//  Created by Maria Luiza Carvalho Sperotto on 30/09/19.
//  Copyright © 2019 Maria Luiza Carvalho Sperotto. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var petitions = [Petition]()
    var filterPetitions = [Petition]()
    
    
    var filteredKeyword: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(showSource))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(askFilter))
        
        title = "Whitehouse Petitions"
        
        let urlString: String
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString =
              "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
    
        if let url = URL(string: urlString) {
         if let data = try? Data(contentsOf: url) {
            // we are ok to parse
            parse(json: data)
            return
            
            }
            
        }
            showError()
            
    }
    
    @objc func askFilter() {
        let alert = UIAlertController(title: "Filter", message: "Filter the petitions on the following keyword: ", preferredStyle: .alert)
        alert.addTextField()
        
        alert.addAction(UIAlertAction(title: "OK", style: .default) {
            [weak self, weak alert] _ in
            self?.filteredKeyword = alert?.textFields?[0].text ?? ""
            self?.filterData()
            self?.tableView.reloadData()
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        
        present(alert, animated: true)
    }
    
    
    func filterData() {
        if filteredKeyword.isEmpty {
            filterPetitions = petitions
            navigationItem.leftBarButtonItem?.title = "Filter"
            return
        }
        
        navigationItem.leftBarButtonItem?.title = "Filter (current: \(filteredKeyword))"
        
        //keep petitions that contains the keyword
        
        filterPetitions = petitions.filter() { petition in
            if let _ = petition.title.range(of: filteredKeyword, options: .caseInsensitive) {
                return true
            }
            
            if let _ = petition.body.range(of: filteredKeyword, options:  .caseInsensitive) {
                return true
            }
            return false
        }
        
        
    
        
    }
    
    @objc func showSource() {
        let alert = UIAlertController(title: "Source", message: "This petitions comes from the We The People API of the Whitehouse", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    
    func showError() {
        let alert = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; Please check your connection and try again", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
    }
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            filterData()
            tableView.reloadData()
        }
    }
    
    
    
    
    
    //table funcs
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterPetitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for:  indexPath)
        let petition = filterPetitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = filterPetitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }


}

