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
        static let loadingCell = "LoadingCell"
      }
    }
    
    struct Segues {
        struct Identifiers {
            static let showDetail = "ShowDetail"
        }
    }
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
        performSearch(searchText: "Ricardo Arjona")
        let cellNib = UINib(nibName: TableView.CellIdentifiers.loadingCell, bundle: nil)
        self.tableView.register(cellNib, forCellReuseIdentifier: TableView.CellIdentifiers.loadingCell)
    }
    
    // MARK: - Functions
    func performSearch(searchText: String) {
        
        search.performSearch(for: searchText , category: .music, completion: { [weak self] result in
            guard let self = self else { return }
            self.tableView.reloadData()
        })
        self.tableView.reloadData()
        
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
            return list.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch search.state {
        case .notSearchedYet:
            return UITableViewCell()
        case .loading:
            let cell = tableView.dequeueReusableCell(withIdentifier: TableView.CellIdentifiers.loadingCell, for: indexPath)
            let spinner = cell.viewWithTag(100) as! UIActivityIndicatorView
            spinner.startAnimating()
            return cell
        case .noResults:
            return UITableViewCell()
        case .results(let list):
            let cell = tableView.dequeueReusableCell(withIdentifier: TableView.CellIdentifiers.searchResultCell, for: indexPath) as! ResultTableViewCell

            let data = list[indexPath.row]
            cell.configure(withData: data)
            return cell
        }
    }


    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segues.Identifiers.showDetail {
            let vc = segue.destination as! ShowDetailViewController
            if case .results(let list) = search.state, let indexPath = tableView.indexPathForSelectedRow {
                let data = list[indexPath.row]
                vc.data = data
            }
        }
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
