//
//  ResultsTableViewCell.swift
//  iOSMediaStore
//
//  Created by Roger Navarro on 4/15/20.
//  Copyright © 2020 Roger Navarro. All rights reserved.
//

import UIKit

class ResultTableViewCell: UITableViewCell {

    //MARK: - IBOutlet
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    //MARK: - Properties
    var downloadTask: URLSessionDownloadTask?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellImage.layer.cornerRadius = 20
        
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        downloadTask?.cancel()
        downloadTask = nil
    }
    
    func configure(withData data: SearchResult) {
        loader.startAnimating()
        artistNameLabel.text = data.artistName
        albumNameLabel.text = data.collectionName
        songNameLabel.text = data.trackName
        cellImage.image = UIImage(named: " ")
        if let smallURL = URL(string: data.imageSmall) {
            downloadTask = cellImage.loadImage(url: smallURL) {
                self.loader.stopAnimating()
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
