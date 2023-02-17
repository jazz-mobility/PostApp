//
//  Dependencies.swift
//  PostApp
//
//  Created by Jasveer Singh on 08.01.23.
//

import UIKit

private struct Constant {
    static let apiBaseURLString = "https://jsonplaceholder.typicode.com"
}

/// `DependencyAccessible` is added to provide dependencies to the app.
protocol DependencyAccessible {}
extension DependencyAccessible {
    static var dependencies: Dependencies {
        DepdendencyContainer()
    }
}

protocol Dependencies {
    var networking: Networking { get }
    var authenticationFactory: AuthenticationFactoryInterface { get }
    var postsFactory: PostsFactoryInterface { get }
}

private final class DepdendencyContainer: Dependencies {
    lazy var networking: Networking = NetworkService(baseURLString: Constant.apiBaseURLString)
    lazy var authenticationFactory: AuthenticationFactoryInterface = AuthenticationFactory(postFactory: postsFactory)
    lazy var postsFactory: PostsFactoryInterface = PostsFactory()
}
