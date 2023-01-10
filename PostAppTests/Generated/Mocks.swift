//
//  UserMocks.swift
//  PostAppTests
//
//  Created by Jasveer Singh on 09.01.23.
//

@testable import PostApp
import Combine

struct Mocks {
    static let user = User(
        id: 1,
        name: "Bret",
        username: "Bret",
        email: "Bret@email.com",
        phone: "0123456789"
    )

    static func loginSuccess(_:String) -> AnyPublisher<User, AuthenticationError> {
        let subject = CurrentValueSubject<User, AuthenticationError>(user)
        return subject.eraseToAnyPublisher()
    }

    static func loginFailure(_:String) -> AnyPublisher<User, AuthenticationError> {
        let subject = PassthroughSubject<User, AuthenticationError>()
        subject.send(completion: .failure(.userNotFound))
        return subject.eraseToAnyPublisher()
    }

    static var posts: Posts = [
        Post(
            userId: 1,
            id: 1,
            title: "Lorem ipsum",
            body: "Lorem ipsum"
        ),
        Post(
            userId: 1,
            id: 2,
            title: "Lorem ipsum",
            body: "Lorem ipsum"
        )
    ]

    static func postsSuccess(_:Int) -> AnyPublisher<Posts, NetworkError> {
        let subject = CurrentValueSubject<Posts, NetworkError>(posts)
        return subject.eraseToAnyPublisher()
    }

    static func postsFailure(_:Int) -> AnyPublisher<Posts, NetworkError> {
        let subject = PassthroughSubject<Posts, NetworkError>()
        subject.send(completion: .failure(.notFound))
        return subject.eraseToAnyPublisher()
    }
}
