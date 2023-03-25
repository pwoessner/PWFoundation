//
//  TestConvenience.swift
//  
//
//  Created by Philipp Woessner on 25.03.23.
//

import Foundation
import XCTest

extension XCTestCase {
    func waitForExpectation(timeout: TimeInterval = .medium) async {
        await waitForExpectations(timeout: timeout)
    }
}
