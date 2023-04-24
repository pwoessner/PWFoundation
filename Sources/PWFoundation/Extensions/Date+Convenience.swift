//
//  Date+Convenience.swift
//  PWEssentials
//
//  Created by Woessner, Philipp on 15.01.22.
//

import Foundation

public extension Date {
    private static let millisecondsToSecondsRatio = 1000

    public init?(milliseconds: Int?) {
        guard let milliseconds else { return nil }
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds / Self.millisecondsToSecondsRatio))
    }

	func getDate(in number: Int, _ component: Calendar.Component) -> Date? {
		Calendar.current.date(byAdding: component, value: number, to: self)
	}

	static var today: Date {
		Calendar.current.startOfDay(for: Date())
	}
}
