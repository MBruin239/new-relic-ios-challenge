//
//  CatList.swift
//  NewRelic
//
//  Created by newrelic on 8/16/20.
//  Copyright © 2020 newrelic. All rights reserved.
//

import Foundation

struct CatDetail: Codable, Equatable, Hashable, Comparable {
    var breed: String
    var country: String
    var origin: String
    var coat: String
    var pattern: String
    
    static func ==(lhs: CatDetail, rhs: CatDetail) -> Bool {
        return lhs.breed == rhs.breed
            && lhs.country == rhs.country
            && lhs.origin == rhs.origin
            && lhs.coat == rhs.coat
            && lhs.pattern == rhs.pattern
    }
    
    static func <(lhs: CatDetail, rhs: CatDetail) -> Bool {
        lhs.breed < rhs.breed
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(breed)
    }
}

struct CatResult: Codable {
    var data: [CatDetail]
    var current_page: Int
    var total: Int
}
