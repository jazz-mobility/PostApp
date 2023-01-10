//
//  XCTestCase+Wait.swift
//  PostAppTests
//
//  Created by Jasveer Singh on 10.01.23.
//

import XCTest

extension XCTestCase {
    func wait(for timeout: TimeInterval = 0.2, expectations: @escaping () -> Void) {
        let expectation = XCTestExpectation(description: "didSatisfyExpectationsAfter(\(timeout)")
        DispatchQueue.global().asyncAfter(deadline: .now() + timeout) {
            expectations()
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: timeout)
    }
}
