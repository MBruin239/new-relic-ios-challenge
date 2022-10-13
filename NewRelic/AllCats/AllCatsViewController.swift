//
//  AllCatsViewController.swift
//  NewRelic
//
//  Created by newrelic on 8/15/20.
//  Copyright © 2020 newrelic. All rights reserved.
//

import UIKit

class AllCatsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var cats: [CatDetail]?
    var downloadState: DownloadState = .downloading

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 140

        // Do any additional setup after loading the view.
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Metrics", style: .plain, target: self, action: #selector(self.rightButtonTapped(sender:)))

        cats = Array(repeating: CatDetail(breed: "", country: "", origin: "", coat: "", pattern: ""), count: 60)
        requestAllCats()
    }
    
    @objc func rightButtonTapped(sender: UIBarButtonItem) {
        let board = UIStoryboard(name: "Main", bundle: nil)
        let metricsView = board.instantiateViewController(withIdentifier: "MetricsViewController")
        if let metricsView = metricsView as? MetricsViewController {
            navigationController?.pushViewController(metricsView, animated: true)
        }
        return
    }
    func requestAllCats() {
        /*
        guard cats == nil else {
            print("cats already loaded")
            return
        }
        */
        let queue = DispatchQueue.main
        
        let dataCallback = { [weak self] (cats: CatResult?) in
            DispatchQueue.main.async {
                self?.downloadState = .done
                self?.cats = cats?.data
                self?.tableView.reloadData()
            }
        }
        CatFetcher.shared.loadCats(perPage: 400, page: 0, queue: queue, callback: dataCallback)
    }
}

extension AllCatsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        guard let cats = cats else {
            return 0
        }
        return cats.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CatCell", for: indexPath) as? CatTableViewCell

        if let breed = cats?[indexPath.row].breed {
            cell?.configure(name: breed, state: downloadState)
        }
        cell?.selectionStyle = .none
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let board = UIStoryboard(name: "Main", bundle: nil)
        let detailsView = board.instantiateViewController(withIdentifier: "CatDetailsViewController")
        if let detailsView = detailsView as? CatDetailsViewController {
            navigationController?.pushViewController(detailsView, animated: true)
        }
    }
}
