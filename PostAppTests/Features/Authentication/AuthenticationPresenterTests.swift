//
//  AuthenticationPresenterTests.swift
//  PostAppTests
//
//  Created by Jasveer Singh on 09.01.23.
//

import XCTest
@testable import PostApp

final class AuthenticationPresenterTests: XCTestCase {
    private var sut: AuthenticationPresenter!
    private var interactor: AuthenticationInteractorInterfaceMock!
    private var router: AuthenticationRoutingMock!
    private var view: AuthenticationViewInterfaceMock!

    override func setUpWithError() throws {
        interactor = AuthenticationInteractorInterfaceMock()
        router = AuthenticationRoutingMock()
        view = AuthenticationViewInterfaceMock()
        sut = AuthenticationPresenter(
            interactor: interactor,
            router: router
        )
        sut.view = view
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testLoginSuccess() {
        // Given
        interactor.loginHandler = Mocks.loginSuccess(_:)
        // When
        sut.didTapLogin(username: "Bret")
        // Then
        XCTAssertEqual(interactor.loginCallCount, 1)
        XCTAssertEqual(router.didFinishAuthenticationCallCount, 1)
        XCTAssertEqual(router.didFinishAuthenticationArgValues.first, Mocks.user)
    }

    func testLoginFailure() {
        // Given
        interactor.loginHandler = Mocks.loginFailure(_:)
        // When
        sut.didTapLogin(username: "Bret")
        // Then
        XCTAssertEqual(interactor.loginCallCount, 1)
        XCTAssertEqual(view.showCallCount, 1)
    }
}
