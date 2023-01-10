//
//  AuthenticationInteractor.swift
//  PostApp
//
//  Created by Jasveer Singh on 08.01.23.
//

import Foundation
import Combine

enum AuthenticationError: Error, CustomStringConvertible {
    case userNotFound
    case emptyUserName

    var description: String {
        switch self {
            case .userNotFound:  return "Invalid username."
            case .emptyUserName:  return "Please enter username."
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
        guard username.count > 0 else {
            return Fail<User, AuthenticationError>(error: .emptyUserName)
                .eraseToAnyPublisher()
        }

        return networking.execute(GetUser(username: username))
            .compactMap({ users in
                users.first
            })
            .mapError { _ in .userNotFound }
            .eraseToAnyPublisher()
    }
}
