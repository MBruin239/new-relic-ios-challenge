//
//  MainCoordinator.swift
//  NewRelic
//
//  Copyright © 2022 newrelicchallenge. All rights reserved.
//

import UIKit

// Using the coordinator pattern for navigation
class MainCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // Called at the start of the application
    func start() {
        let vc = ViewControllerProvider.allCatsViewController
        vc.coordinator = self
        
        navigationController.pushViewController(vc, animated: false)
    }

    // Called to show the cat details view controller
    func showCatDetailsViewController(catDetail: CatDetail) {
        let vc = ViewControllerProvider.catDetailsViewController(cat: catDetail)
        navigationController.pushViewController(vc, animated: true)
    }
    
    // Called to show the metrics view controller
    func showMetricsViewController(averageTime: Millisecond) {
        let vc = ViewControllerProvider.metricsViewController(averageTime: averageTime)
        navigationController.pushViewController(vc, animated: true)
    }
}
