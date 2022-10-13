//
//  AllCatsViewController.swift
//  NewRelic
//
//  Created by newrelic on 8/15/20.
//  Copyright © 2020 newrelic. All rights reserved.
//

import UIKit

class AllCatsViewController: UIViewController {
    var coordinator: MainCoordinator?
    
    var viewModel = CatsViewModel()

    @IBOutlet weak var tableView: UITableView!
    
    var downloadState: DownloadState = .downloading { didSet {
        switch downloadState {
        case .downloading:
            self.tableView.tableFooterView?.isHidden = false
        case .done:
            self.tableView.tableFooterView?.isHidden = true
        }
    }}

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 140
        
        // An activity indicator to indicate the the cats are still downloading
        let spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        spinner.startAnimating()
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
        self.tableView.tableFooterView = spinner
        
        // Do any additional setup after loading the view.
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Metrics", style: .plain, target: self, action: #selector(self.rightButtonTapped(sender:)))
        
        // Closure for when all the cats are done dowloading
        viewModel.allCatsDownloaded.onUpdate = { [weak self] _ in
            self?.downloadState = .done
            self?.tableView.reloadData()
        }
        // Closure for when the cats array is updated
        viewModel.cats.onUpdate = { [weak self] _ in
            self?.tableView.reloadData()
        }

        // start downloading all the cats
        requestAllCats()
    }
    
    // A function to request the cats in the view controller
    func requestAllCats() {
        downloadState = .downloading
        
        viewModel.requestAllCats()
    }
    
    @objc func rightButtonTapped(sender: UIBarButtonItem) {
        coordinator?.showMetricsViewController(averageTime: viewModel.catTimeManager.getAverageTimes())
    }
}

extension AllCatsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return viewModel.cats.value.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CatCell", for: indexPath) as? CatTableViewCell else { return UITableViewCell() }
        
        let cat = viewModel.cats.value[indexPath.row]
        let breed = cat.breed
        
        cell.configure(name: breed, state: .done)

        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cat = viewModel.cats.value[indexPath.row]
        self.coordinator?.showCatDetailsViewController(catDetail: cat)
    }

}
