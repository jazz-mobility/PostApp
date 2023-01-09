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

    init(
        navigationController: UINavigationController
    ) {
        self.navigationController = navigationController
    }
}

extension AuthenticationRouter: AuthenticationRouting {
    func authenticateUser() {
        navigationController.pushViewController(viewController, animated: false)
    }
}

extension AuthenticationRouter: AuthenticationRoutingDelegate {
    func didFinishAuthentication(user: User) {

    }
}
