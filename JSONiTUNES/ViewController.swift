//
//  ViewController.swift
//  JSONiTUNES
//
//  Created by Volodymyr Ostapyshyn on 08.12.2020.
//

import UIKit

class ViewController: UIViewController {
    
    let networkService = NetworkService()
    var searchResponse: SearchResponse? = nil

    @IBOutlet var table: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupTableView()
        
        let urlString = "https://itunes.apple.com/search?term=jack+johnson&limit=21"
        
        networkService.request(urlString: urlString) { result in
            switch result {
            case .success(let searchResponse):
                self.searchResponse = searchResponse
                searchResponse.results.map { track in
                    print("track.trackName:", track.trackName)
                }
            case .failure(let error):
                print("error:", error)
            }
        }
    }
    
    private func setupTableView() {
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = true
        searchController.obscuresBackgroundDuringPresentation = false
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResponse?.results.count ?? 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "123"
        return cell
    }

}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}
