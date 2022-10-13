//
//  CatTableViewCell.swift
//  NewRelic
//
//  Created by newrelic on 8/16/20.
//  Copyright © 2020 newrelic. All rights reserved.
//

import UIKit

enum DownloadState {
    case downloading
    case done
}
class CatTableViewCell: UITableViewCell {
    @IBOutlet weak var backing: UIView!
    @IBOutlet weak var catName: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func configure(name: String, state: DownloadState) {
        catName.text = name
        switch state {
            case .downloading:
                activityIndicator.startAnimating()
            case .done:
                activityIndicator.stopAnimating()
                activityIndicator.isHidden = true
        }
    }
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        backing.backgroundColor = highlighted ? UIColor.yellow : UIColor.white
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
