//
//  CatDetailTableViewCell.swift
//  NewRelic
//
//  Created by newrelic on 8/16/20.
//  Copyright © 2020 newrelic. All rights reserved.
//

import UIKit

class CatDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var detailValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func configure(_ catAttribute: CatAttribute) {
        detailLabel.text = catAttribute.label
        detailValue.text = catAttribute.value
    }
}
