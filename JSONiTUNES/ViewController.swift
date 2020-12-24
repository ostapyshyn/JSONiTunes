//
//  ViewController.swift
//  JSONiTUNES
//
//  Created by Volodymyr Ostapyshyn on 08.12.2020.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var table: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupTableView()
        
        let urlString = "https://itunes.apple.com/search?term=jack+johnson&limit=24"
        
        request(urlString: urlString) { (searchResponse, error) in
            searchResponse?.results.map({ (track) in
                print(track.trackName)
            })
        }
    }
    
    func request(urlString: String, completion: @escaping (SearchResponse?, Error?) -> Void) { //add result
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print("some error")
                    completion(nil, error)
                    return
                }
                guard let data = data else { return }
                
                do {
                    let tracks = try JSONDecoder().decode(SearchResponse.self, from: data)
                    completion(tracks, nil)
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                    completion(nil, jsonError)
                }
                let text = String(data: data, encoding: .utf8)
                print(text ?? "no data")
            }
        }.resume()
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
        return 3
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
