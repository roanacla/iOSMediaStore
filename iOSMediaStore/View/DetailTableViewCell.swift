//
//  DetailTableViewCell.swift
//  iOSMediaStore
//
//  Created by Roger Navarro on 4/16/20.
//  Copyright © 2020 Roger Navarro. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    //MARK: - IBOUtlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    //MARK: - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(title: String, detail: String) {
        self.titleLabel.text = title
        self.detailLabel.text = detail
    }

}
