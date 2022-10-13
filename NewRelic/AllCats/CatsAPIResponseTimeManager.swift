//
//  CatsAPIResponseTimeManager.swift
//  NewRelic
//
//  Copyright © 2022 newrelicchallenge. All rights reserved.
//

import Foundation

// Make a special class for Milliseconds for readablity
typealias Millisecond = Int

// A small class for managing the web request times
class CatsAPIResponseTimeManager {
    var times = [Millisecond]()
    
    func getAverageTimes() -> Millisecond {
        guard !times.isEmpty else { return 0 }
        
        let sumArray = times.reduce(0, +)

        return sumArray / Millisecond(times.count)
    }
}
