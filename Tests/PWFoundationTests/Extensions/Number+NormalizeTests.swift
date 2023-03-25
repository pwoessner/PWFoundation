//
//  Number+NormalizeTests.swift
//  
//
//  Created by Philipp Woessner on 25.03.23.
//

import XCTest

class NumberNormalizeTests: XCTestCase {
    func testNormalize_NumbersNormalized() {
        let sut = [1.0, 2.0, 3.0, 4.0, 5.0]
        XCTAssertEqual(sut.normalized(), [0, 0.25, 0.5, 0.75, 1])
    }

    func testNormalize_EmptyArray() {
        let sut: [Double] = []
        XCTAssertNil(sut.normalized())
    }

    func testNormalize_MinEqualsMax() {
        let sut: [Double] = [2.0, 2.0, 2.0]
        XCTAssertNil(sut.normalized())
    }
}
