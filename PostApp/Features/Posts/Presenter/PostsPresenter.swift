//
//  PostsPresenter.swift
//  PostApp
//
//  Created by Jasveer Singh on 09.01.23.
//

import Foundation
import Combine

/// @mockable
protocol PostsPresenterInterface: AnyObject {
    func viewDidLoad()
}

final class PostsPresenter {
    private var cancellableSet: Set<AnyCancellable> = []
    weak var view: PostsViewInterface?
    private let interactor: PostsInteractorInterface
    private let router: PostsRoutingDelegate
    private let user: User

    init(
        interactor: PostsInteractorInterface,
        router: PostsRoutingDelegate,
        user: User
    ) {
        self.interactor = interactor
        self.router = router
        self.user = user
    }
}

extension PostsPresenter: PostsPresenterInterface {
    func viewDidLoad() {
        interactor.fetchPosts(userId: user.id)
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                switch completion {
                    case .failure(let error):
                        self?.view?.show(error: String(describing: error))
                    case .finished: break
                }
            } receiveValue: { [weak self] posts in
                self?.view?.show(posts: posts)
            }
            .store(in: &cancellableSet)
    }
}
