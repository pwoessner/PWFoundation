//
//  NumberFormatter+Abbreviate.swift
//  
//
//  Created by Woessner, Philipp on 23.03.23.
//

import Foundation

public extension NumberFormatter {
    func abbreviate(_ number: Int?, separator: Int = 1_000) -> String? {
        guard let number else { return nil }
        var scale = 0
        var shortNumber = number
        while shortNumber / separator > 1 {
            shortNumber = shortNumber / separator
            scale += 1
        }

        if let suffix = Scale(rawValue: scale)?.char {
            self.positiveSuffix = suffix
        }

        return self.string(from: NSNumber(value: shortNumber))
    }
}

public enum Scale: Int {
    case underThousand = 0
    case thousand = 1
    case million = 2
    case billion = 3

    var char: String? {
        switch self {
        case .thousand:
            return "k"
        case .million:
            return "M"
        case .billion:
            return "B"
        default:
            return nil
        }
    }
}
