//
//  SortComparator+Evaluate.swift
//  
//
//  Created by Philipp Wössner on 09.04.23.
//

import Foundation

public extension SortComparator {
    func evaluate(condition: Bool) -> ComparisonResult {
        switch order {
        case .reverse:
            return condition ? .orderedAscending : .orderedDescending
        case .forward:
            return condition ? .orderedDescending : .orderedAscending
        }
    }
}
