//
//  PostsPresenterTests.swift
//  PostAppTests
//
//  Created by Jasveer Singh on 10.01.23.
//

import XCTest
@testable import PostApp

final class PostsPresenterTests: XCTestCase {
    private var sut: PostsPresenter!
    private var interactor: PostsInteractorInterfaceMock!
    private var router: PostsRoutingMock!
    private var view: PostsViewInterfaceMock!

    override func setUpWithError() throws {
        interactor = PostsInteractorInterfaceMock()
        router = PostsRoutingMock()
        view = PostsViewInterfaceMock()
        sut = PostsPresenter(
            interactor: interactor,
            router: router,
            user: Mocks.user
        )
        sut.view = view
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testFetchPostsSuccess() {
        // Given
        interactor.fetchPostsHandler = Mocks.postsSuccess(_:)
        // When
        sut.viewDidLoad()
        // Then
        XCTAssertEqual(interactor.fetchPostsCallCount, 1)
        wait {
            XCTAssertEqual(self.view.showPostsCallCount, 1)
            XCTAssertEqual(self.view.showPostsArgValues.first, Mocks.posts)
        }
    }

    func testFetchPostsFailure() {
        // Given
        interactor.fetchPostsHandler = Mocks.postsFailure(_:)
        // When
        sut.viewDidLoad()
        // Then
        XCTAssertEqual(interactor.fetchPostsCallCount, 1)
        wait {
            XCTAssertEqual(self.view.showCallCount, 1)
        }
    }
}
