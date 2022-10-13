//
//  Coordinator.swift
//  NewRelic
//
//  Copyright © 2022 newrelicchallenge. All rights reserved.
//

import UIKit

// Define what a coordinator must include
protocol Coordinator {
    var navigationController: UINavigationController { get set }

    func start()
}
