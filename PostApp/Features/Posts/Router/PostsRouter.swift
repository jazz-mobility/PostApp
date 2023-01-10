//
//  PostsRouter.swift
//  PostApp
//
//  Created by Jasveer Singh on 09.01.23.
//

import UIKit

protocol PostsRoutingDelegate: AnyObject {
    func showComments(for post: Post)
}

/// @mockable
protocol PostsRouting: PostsRoutingDelegate {
    func showPosts()
}

final class PostsRouter {
    var viewController: UIViewController!
    private let navigationController: UINavigationController

    init(
        navigationController: UINavigationController
    ) {
        self.navigationController = navigationController
    }
}

extension PostsRouter: PostsRouting {
    func showPosts() {
        navigationController.viewControllers = [viewController]
    }
}

extension PostsRouter: PostsRoutingDelegate {
    func showComments(for post: Post) {

    }
}
