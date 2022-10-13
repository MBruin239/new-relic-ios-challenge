//
//  Variable.swift
//  NewRelic
//
//  Copyright © 2022 newrelicchallenge. All rights reserved.
//

import Foundation

// A class that holds a value and calls a closure when the value is set
class Variable<Value> {
    var value: Value {
        didSet {
            DispatchQueue.main.async {
                self.onUpdate?(self.value)
            }
        }
    }
    
    // The closure defined and stored
    var onUpdate: ((Value) -> Void)?

    // Create with a generic value and a closure
    init(_ value: Value, _ onUpdate: ((Value) -> Void)? = nil) {
        self.value = value
        self.onUpdate = onUpdate
    }
}
