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
        id: 0,
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
}
