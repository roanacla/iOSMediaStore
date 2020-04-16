//
//  ShowDetailViewController.swift
//  iOSMediaStore
//
//  Created by Roger Navarro on 4/15/20.
//  Copyright © 2020 Roger Navarro. All rights reserved.
//

import UIKit

class ShowDetailViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var largeImageView: UIImageView!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var detailTableView: UITableView!
    
    //MARK: - Properties
    var data: SearchResult?
    var detailData: [String] = []
    struct TableView {
      struct CellIdentifiers {
        static let detailCell = "DetailCell"
      }
    }
    
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        largeImageView.layer.cornerRadius = 20
        largeImageView.image = UIImage(named: " ")
        if let data = data {
            if let largeImageURL = URL(string: data.imageLarge) {
                _ = largeImageView.loadImage(url: largeImageURL)
            }
            songNameLabel.text = data.trackName
            artistNameLabel.text = data.artistName
            detailData.append(data.collectionName ?? "")
            detailData.append(data.genre)
            detailData.append(data.kind ?? "")
            detailData.append("\(data.itemPrice ?? 0.99)")
            detailData.append(data.currency)
        }
    }

}

extension ShowDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DetailAttributes.attributes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableView.CellIdentifiers.detailCell, for: indexPath) as! DetailTableViewCell
        
        let title = DetailAttributes.attributes[indexPath.row]
        let detail = detailData[indexPath.row]
        cell.configure(title: title, detail: detail)
        
        return cell
    }
    
    
}
