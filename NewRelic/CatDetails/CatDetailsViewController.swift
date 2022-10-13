//
//  CatDetailsViewController.swift
//  NewRelic
//
//  Created by newrelic on 8/16/20.
//  Copyright © 2020 newrelic. All rights reserved.
//

import Foundation

import UIKit

struct CatAttribute {
    let label: String
    let value: String
}

class CatDetailsViewController: UIViewController {

    var catDetail: CatDetail?
    var catDetailTableArray = [CatAttribute]()
        
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 140
        tableView.separatorStyle = .none
        tableView.bounces = false
    }
    
    // Function to setup the cat details table
    public func setCatDetails(catDetail: CatDetail) {
        self.catDetail = catDetail
        catDetailTableArray.removeAll()
        
        catDetailTableArray.append(CatAttribute(label: "Breed", value: catDetail.breed))
        catDetailTableArray.append(CatAttribute(label: "Country", value: catDetail.country))
        catDetailTableArray.append(CatAttribute(label: "Origin", value: catDetail.origin))
        catDetailTableArray.append(CatAttribute(label: "Coat", value: catDetail.coat))
        catDetailTableArray.append(CatAttribute(label: "Pattern", value: catDetail.pattern))
        
    }
}

extension CatDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        // breed, country, origin, coat, pattern => 5
        return catDetailTableArray.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CatDetailCell", for: indexPath) as? CatDetailTableViewCell else { return UITableViewCell() }
        
        cell.configure(catDetailTableArray[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
}
