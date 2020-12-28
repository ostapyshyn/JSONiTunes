//
//  ViewController.swift
//  JSONiTUNES
//
//  Created by Volodymyr Ostapyshyn on 08.12.2020.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
    
    let networkDataFetcher = NetworkDataFetcher()
    var searchResponse: SearchResponse? = nil
    private var timer: Timer?
    
    @IBOutlet var table: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupTableView()
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
        let track = searchResponse?.results[indexPath.row]
        let imageUrl = searchResponse?.results[indexPath.row].artworkUrl60
        cell.textLabel?.text = track?.trackName
        
        guard let string = imageUrl, let url = URL(string: string) else { return cell }
        
        cell.imageView?.sd_setImage(with: url, placeholderImage: UIImage(named: "download"), options: [.continueInBackground], completed: nil)
        
        return cell
    }

}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let urlString = "https://itunes.apple.com/search?term=\(searchText)&limit=8"
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            self.networkDataFetcher.fetchTracks(urlString: urlString) { (searchResponse) in
                guard let searchResponse = searchResponse else { return }
                self.searchResponse = searchResponse
                self.table.reloadData()
            }
        })
        print(searchText)
    }
}
