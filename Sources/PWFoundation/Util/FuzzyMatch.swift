//
//  FuzzyMatch.swift
//  
//
//  Created by Woessner, Philipp on 30.03.23.
//

import Foundation

public extension String {
    func fuzzyMatch(_ searchString: String) -> Bool {
        if searchString.isEmpty { return true }
        var remainder = searchString[...]
        for char in self where char == remainder[remainder.startIndex] {
            remainder.removeFirst()
            if remainder.isEmpty { return true }
        }
        return false
    }
}
