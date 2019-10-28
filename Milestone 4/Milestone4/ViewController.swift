//
//  ViewController.swift
//  Milestone4
//
//  Created by Maria Luiza Carvalho Sperotto on 28/10/19.
//  Copyright © 2019 Maria Luiza Carvalho Sperotto. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UITableViewController, UISearchResultsUpdating {
    var countries = [Country]()
    var selectedCountry: Country?
    let url = "https://restcountries.eu/rest/v2/all"
    let searchController = UISearchController(searchResultsController: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search for a country"
        getCountries(url: url)
        searchController.searchResultsUpdater = self
        definesPresentationContext = true
        searchController.obscuresBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        
        
        
}
    
    func updateSearchResults(for searchController: UISearchController) {
           filterSearchController(searchBar: searchController.searchBar)
       }
    
    func filterSearchController(searchBar: UISearchBar) {
        let text = searchBar.text ?? ""
        let search = text.replacingOccurrences(of: " ", with: "+")
        if text == "" {
            getCountries(url: url)
        }
        let path = "https://restcountries.eu/rest/v2/name/\(search)"
        getCountries(url: path)
    }
    
    func getCountries(url: String) {
        Alamofire.request(url, method: .get).responseData { (response) in
            guard let dados = response.data else { return }
            do {
                let decoder = JSONDecoder()
                let search = try decoder.decode([Country].self, from: dados)
                self.countries = search
                self.tableView.reloadData()
                
            } catch let error {
                print(error)
            }
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Country", for: indexPath)
        let country = countries[indexPath.row]
        cell.textLabel?.text = country.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let country = countries[indexPath.row]
        selectedCountry = country
        performSegue(withIdentifier: "Detail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Detail" {
            let countryDetail = segue.destination as! DetailViewController
            countryDetail.country = selectedCountry
        }
    }


}


