//
//  AuthenticationView.swift
//  PostApp
//
//  Created by Jasveer Singh on 08.01.23.
//

import UIKit

private struct Constant {
    struct Text {
        static let userIdLabel = "Username:"
        static let userIdPlaceholder = "Please enter user id"
        static let loginButton = "Login".capitalized
    }
}

protocol AuthenticationViewDelegate: AnyObject {
    func didTapLogin(username: String)
}

final class AuthenticationView: UIView {
    private lazy var userIdLabel: UILabel = {
        let label = UILabel()
        label.text = Constant.Text.userIdLabel
        return label
    }()

    private lazy var userIdTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Constant.Text.userIdPlaceholder
        textField.borderStyle = .bezel
        textField.textContentType = .username
        textField.keyboardType = .emailAddress
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        return textField
    }()

    private lazy var userIdStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [userIdLabel, userIdTextField])
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.distribution = .equalSpacing

        return stackView
    }()

    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constant.Text.loginButton, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.configuration = .borderedProminent()
        button.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        return button
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [userIdStackView, loginButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .equalCentering
        addSubview(stackView)

        return stackView
    }()

    private weak var delegate: AuthenticationViewDelegate?

    init(delegate: AuthenticationViewDelegate) {
        super.init(frame: .zero)
        self.delegate = delegate

        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
        backgroundColor = .systemBackground
    }

    @objc private func didTapLogin() {
        delegate?.didTapLogin(username: userIdTextField.text ?? "")
    }
}
