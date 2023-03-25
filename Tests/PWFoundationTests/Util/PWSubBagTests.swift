//
//  PWSubBagTests.swift
//  
//
//  Created by Philipp Woessner on 25.03.23.
//

import XCTest
import Combine
import PWFoundation

class PWSubBagTests: XCTestCase {
    @Published var testPublished: Bool = true
    private var sut: PWSubBag!

    override func setUp() {
        super.setUp()

        sut = PWSubBag()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testDispose_AllRemoved() async {
        // Arrange
        let expectCancel = expectation(description: "Expect cancellable to be canceled")
        let testCancellable = AnyCancellable({
            expectCancel.fulfill()
        })
        sut.insert(testCancellable)

        // Act
        sut.dispose()
        await waitForExpectation()

        // Assert
        XCTAssertEqual(sut.count, 0, "")
    }
}
