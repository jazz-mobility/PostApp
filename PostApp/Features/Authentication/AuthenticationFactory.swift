//
//  AuthenticationAssembly.swift
//  PostApp
//
//  Created by Jasveer Singh on 09.01.23.
//

import UIKit

protocol AuthenticationFactoryInterface {
    func make(with navigationController: UINavigationController) -> AuthenticationRouting
}

final class AuthenticationFactory: AuthenticationFactoryInterface, DependencyAccessible {
    private let postsFactory: PostsFactoryInterface

    init(postFactory: PostsFactoryInterface) {
        self.postsFactory = postFactory
    }

    func make(with navigationController: UINavigationController) -> AuthenticationRouting {
        let interactor = AuthenticationInteractor(networking: Self.dependencies.networking)
        let router = AuthenticationRouter(navigationController: navigationController, postsFactory: postsFactory)
        let presenter = AuthenticationPresenter(interactor: interactor, router: router)
        let viewController = AuthenticationViewController(presenter: presenter)
        presenter.view = viewController
        router.viewController = viewController

        return router
    }
}
