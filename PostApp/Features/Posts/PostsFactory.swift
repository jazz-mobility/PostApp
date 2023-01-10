//
//  PostsFactory.swift
//  PostApp
//
//  Created by Jasveer Singh on 09.01.23.
//

import UIKit

protocol PostsFactoryInterface {
    func make(for user: User, with navigationController: UINavigationController) -> PostsRouter
}

final class PostsFactory: PostsFactoryInterface, DependencyAccessible {
    func make(for user: User, with navigationController: UINavigationController) -> PostsRouter {
        let interactor = PostsInteractor(networking: Self.dependencies.networking)
        let router = PostsRouter(navigationController: navigationController)
        let presenter = PostsPresenter(interactor: interactor, router: router, user: user)
        let viewController = PostsViewController(presenter: presenter)
        presenter.view = viewController
        router.viewController = viewController

        return router
    }
}
