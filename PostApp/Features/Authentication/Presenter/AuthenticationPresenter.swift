//
//  AuthenticationPresenter.swift
//  PostApp
//
//  Created by Jasveer Singh on 08.01.23.
//

import Foundation
import Combine

/// @mockable
protocol AuthenticationPresenterInterface: AnyObject {
    func didTapLogin(username: String)
}

final class AuthenticationPresenter {
    private var cancellableSet: Set<AnyCancellable> = []
    weak var view: AuthenticationViewInterface?
    private let interactor: AuthenticationInteractorInterface
    private let router: AuthenticationRoutingDelegate

    init(
        interactor: AuthenticationInteractorInterface,
        router: AuthenticationRoutingDelegate
    ) {
        self.interactor = interactor
        self.router = router
    }
}

extension AuthenticationPresenter: AuthenticationPresenterInterface {
    func didTapLogin(username: String) {
        interactor.login(username: username)
            .sink { [weak self] completion in
                switch completion {
                    case .failure(let error):
                        self?.view?.show(error: String(describing: error))
                    case .finished: break
                }
            } receiveValue: { [weak self] user in
                self?.router.didFinishAuthentication(user: user)
            }
            .store(in: &cancellableSet)
    }
}
