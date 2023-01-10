//
//  ViewController.swift
//  PostApp
//
//  Created by Jasveer Singh on 05.01.23.
//

import UIKit

/// @mockable
protocol AuthenticationViewInterface: AnyObject {
    func show(error: String)
}

final class AuthenticationViewController: UIViewController {
    private let presenter: AuthenticationPresenterInterface

    init(
        presenter: AuthenticationPresenterInterface
    ) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func loadView() {
        super.loadView()
        view = AuthenticationView(delegate: self)
    }
}

extension AuthenticationViewController: AuthenticationViewInterface {
    func show(error: String) {
        showAlert(text: error)
    }
}

extension AuthenticationViewController: AuthenticationViewDelegate {
    func didTapLogin(username: String) {
        presenter.didTapLogin(username: username)
    }
}
