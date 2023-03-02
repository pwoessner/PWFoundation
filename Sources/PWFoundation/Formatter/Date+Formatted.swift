//
//  Date+Formatted.swift
//  
//
//  Created by Philipp Woessner on 02.03.23.
//

import Foundation

public extension Date {
    func localized(dateStyle: DateFormatter.Style = .short, timeStyle: DateFormatter.Style = .short) -> String {
        DateFormatter.localizedString(from: self, dateStyle: dateStyle, timeStyle: timeStyle)
    }

    func localized(format: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
