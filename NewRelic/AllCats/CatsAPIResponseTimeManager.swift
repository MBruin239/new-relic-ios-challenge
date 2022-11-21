//
//  CatsAPIResponseTimeManager.swift
//  NewRelic
//
//  Copyright © 2022 newrelicchallenge. All rights reserved.
//

import Foundation

// Make a special class for Milliseconds for readablity
typealias Millisecond = Int

struct APITimeObject {
    let time: Millisecond
    let url: String
    
    init(time: Millisecond, url: String) {
        self.time = time
        self.url = url
    }
}

// A small class for managing the web request times
class CatsAPIResponseTimeManager {
    var times = [APITimeObject]()
    
    func getAverageTimes() -> Millisecond {
        guard !times.isEmpty else { return 0 }
        
        var totalTime = 0
        for time in times {
            totalTime += time.time
        }
        
        return totalTime / Millisecond(times.count)
    }
}
