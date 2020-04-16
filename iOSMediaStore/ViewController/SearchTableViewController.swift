//
//  SearchTableViewController.swift
//  iOSMediaStore
//
//  Created by Roger Navarro on 4/15/20.
//  Copyright © 2020 Roger Navarro. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController {
    
    //MARK: - IBOutlet
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    //MARK: - Data
    private let search = Search()
    
    
    //MARK: - Properties
    struct TableView {
      struct CellIdentifiers {
        static let searchResultCell = "SearchResultCell"
        static let nothingFoundCell = "NothingFoundCell"
        static let loadingCell = "LoadingCell"
      }
    }
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
    }
    
    // MARK: - Functions
    func performSearch(searchText: String) {
        
        search.performSearch(for: searchText , category: .music, completion: { [weak self] result in
            guard let self = self else { return }
            self.tableView.reloadData()
        })
        
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch search.state {
        case .notSearchedYet:
            return 0
        case .loading:
            return 1
        case .noResults:
            return 1
        case .results(let list):
            print(list.count)
            return list.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch search.state {
        case .notSearchedYet:
            return UITableViewCell()
        case .loading:
            return UITableViewCell()
        case .noResults:
            return UITableViewCell()
        case .results(let list):
            let cell = tableView.dequeueReusableCell(withIdentifier: TableView.CellIdentifiers.searchResultCell, for: indexPath) as! ResultTableViewCell
            
            let data = list[indexPath.row]
            print(data)
            cell.configure(withData: data)
            return cell
        }
    }


    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    

}

extension SearchTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
        let searchText = self.searchBar.text
        guard let text = searchText else { return }
        performSearch(searchText: text)
    }
}
