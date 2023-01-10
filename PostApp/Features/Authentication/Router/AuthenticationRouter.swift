//
//  AuthenticationRouter.swift
//  PostApp
//
//  Created by Jasveer Singh on 08.01.23.
//

import UIKit

protocol AuthenticationRoutingDelegate {
    func didFinishAuthentication(user: User)
}

/// @mockable
protocol AuthenticationRouting: AuthenticationRoutingDelegate {
    func authenticateUser()
}

final class AuthenticationRouter {
    var viewController: UIViewController!
    private let navigationController: UINavigationController
    private let postsFactory: PostsFactoryInterface

    init(
        navigationController: UINavigationController,
        postsFactory: PostsFactoryInterface
    ) {
        self.navigationController = navigationController
        self.postsFactory = postsFactory
    }
}

extension AuthenticationRouter: AuthenticationRouting {
    func authenticateUser() {
        navigationController
            .pushViewController(viewController, animated: false)
    }
}

extension AuthenticationRouter: AuthenticationRoutingDelegate {
    func didFinishAuthentication(user: User) {
        postsFactory
            .make(for: user, with: navigationController)
            .showPosts()
    }
}
