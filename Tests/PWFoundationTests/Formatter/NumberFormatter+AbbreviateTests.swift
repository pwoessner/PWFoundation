//
//  NumberFormatter+AbbreviateTests.swift
//  
//
//  Created by Philipp Woessner on 25.03.23.
//

import Foundation
import XCTest
import PWFoundation

class NumberFormatterAbbreviateTests: XCTestCase {
    private var sut: NumberFormatter!

    private let oneDigit = 9
    private let twoDigit = 99
    private let threeDigit = 999

    private let thousand = 1_000
    private let million = 1_000_000
    private let billion = 1_000_000_000

    override func setUp() {
        super.setUp()
        sut = NumberFormatter()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testAbbreviate_NumberIsNil() {
        XCTAssertNil(sut.abbreviate(nil))
    }

    func testAbbreviate_WithNoSuffix_OneDigit() {
        XCTAssertEqual(sut.abbreviate(oneDigit), "9")
    }

    func testAbbreviate_WithNoSuffix_TwoDigits() {
        XCTAssertEqual(sut.abbreviate(twoDigit), "99")
    }

    func testAbbreviate_WithNoSuffix_ThreeDigits() {
        XCTAssertEqual(sut.abbreviate(threeDigit), "999")
    }

    func testAbbreviate_WithThousandSuffix_OneDigit() {
        XCTAssertEqual(sut.abbreviate(oneDigit * thousand), "9K")
    }

    func testAbbreviate_WithThousandSuffix_TwoDigit() {
        XCTAssertEqual(sut.abbreviate(twoDigit * thousand), "99K")
    }

    func testAbbreviate_WithThousandSuffix_ThreeDigit() {
        XCTAssertEqual(sut.abbreviate(threeDigit * thousand), "999K")
    }

    func testAbbreviate_WithMillionSuffix_OneDigit() {
        XCTAssertEqual(sut.abbreviate(oneDigit * million), "9M")
    }

    func testAbbreviate_WithMillionSuffix_TwoDigit() {
        XCTAssertEqual(sut.abbreviate(twoDigit * million), "99M")
    }

    func testAbbreviate_WithMillionSuffix_ThreeDigit() {
        XCTAssertEqual(sut.abbreviate(threeDigit * million), "999M")
    }

    func testAbbreviate_WithBillionSuffix_OneDigit() {
        XCTAssertEqual(sut.abbreviate(oneDigit * billion), "9B")
    }

    func testAbbreviate_WithBillionSuffix_TwoDigit() {
        XCTAssertEqual(sut.abbreviate(twoDigit * billion), "99B")
    }

    func testAbbreviate_WithBillionSuffix_ThreeDigit() {
        XCTAssertEqual(sut.abbreviate(threeDigit * billion), "999B")
    }
}
