//
//  PostsInteractor.swift
//  PostApp
//
//  Created by Jasveer Singh on 09.01.23.
//

import Combine

/// @mockable
protocol PostsInteractorInterface {
    func fetchPosts(userId: Int) -> AnyPublisher<Posts, NetworkError>
}

final class PostsInteractor {
    private let networking: Networking

    init(networking: Networking) {
        self.networking = networking
    }
}

extension PostsInteractor: PostsInteractorInterface {
    func fetchPosts(userId: Int) -> AnyPublisher<Posts, NetworkError> {
        networking.execute(GetPosts(userId: userId))
            .eraseToAnyPublisher()
    }
}
