//
//  Normalize.swift
//  
//
//  Created by Woessner, Philipp on 24.03.23.
//

import Foundation

public extension Array where Element: Numeric & Comparable & FloatingPoint {
    func normalized() -> [Element]? {
        guard let min = self.min(),
              let max = self.max(),
              min != max else {
            return nil
        }

        let diff = max - min
        return self.map { ($0 - min) / diff }
    }
}
