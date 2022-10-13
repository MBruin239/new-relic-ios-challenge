//
//  MetricsViewController.swift
//  NewRelic
//
//  Created by newrelic on 8/16/20.
//  Copyright © 2020 newrelic. All rights reserved.
//

import Foundation
import UIKit

struct MetricsAttribute {
    let label: String
    let value: String
}

class MetricsViewController: UIViewController {
    var metricDetailsTableArray = [MetricsAttribute]()
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Metrics"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 140
        tableView.separatorStyle = .none
        tableView.bounces = false
    }
    
    // Function to set the metric information for the table view
    public func setMetricDetails(averageTime: Millisecond) {
        metricDetailsTableArray.removeAll()
        
        let systemVersion = UIDevice.current.systemVersion
        let model = UIDevice.current.name
        
        metricDetailsTableArray.append(MetricsAttribute(label: "AVG HTTP Response Time", value: String(averageTime) + " " + "milliseconds"))
        metricDetailsTableArray.append(MetricsAttribute(label: "Make/Model", value: model))
        metricDetailsTableArray.append(MetricsAttribute(label: "OS Version", value: systemVersion))

    }
}

extension MetricsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        // average response time, make/model, os version => 3
        return metricDetailsTableArray.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MetricsCell", for: indexPath) as? MetricsTableViewCell else { return UITableViewCell() }

        cell.configure(metricDetailsTableArray[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
}
