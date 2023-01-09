//
//  AuthenticationInteractor.swift
//  PostApp
//
//  Created by Jasveer Singh on 08.01.23.
//

import Foundation
import Combine

enum AuthenticationError: Error {
    case userNotFound

    var description: String? {
        switch self {
               case .userNotFound:  return "Invalid username."
        }
    }
}

/// @mockable
protocol AuthenticationInteractorInterface {
    func login(username: String) -> AnyPublisher<User, AuthenticationError>
}

final class AuthenticationInteractor {
    private let networking: Networking

    init(networking: Networking) {
        self.networking = networking
    }
}

extension AuthenticationInteractor: AuthenticationInteractorInterface {
    func login(username: String) -> AnyPublisher<User, AuthenticationError> {
        networking.execute(GetUser(username: username))
            .compactMap({ users in
                users.first
            })
            .mapError { _ in .userNotFound }
            .eraseToAnyPublisher()
    }
}
