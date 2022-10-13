//
//  ViewControllerProvider.swift
//  NewRelic
//
//  Copyright © 2022 newrelicchallenge. All rights reserved.
//

import UIKit

enum ViewControllerProvider {
    // Provides an AllCatsViewController
    static var allCatsViewController: AllCatsViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "AllCatsViewController") as! AllCatsViewController
        return viewController
    }

    // Provides a CatDetailsViewController
    static func catDetailsViewController(cat: CatDetail) -> CatDetailsViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "CatDetailsViewController") as! CatDetailsViewController

        viewController.setCatDetails(catDetail: cat)
        
        return viewController
    }
    
    // Provides a MetricsViewController
    static func metricsViewController(averageTime: Millisecond) -> MetricsViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "MetricsViewController") as! MetricsViewController
        
        viewController.setMetricDetails(averageTime: averageTime)
        return viewController
    }
}
