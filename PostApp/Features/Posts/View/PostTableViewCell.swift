//
//  PostTableViewCell.swift
//  PostApp
//
//  Created by Jasveer Singh on 10.01.23.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    static let reuseIdentifier = "PostTableViewCell"

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .gray
        return label
    }()

    private lazy var favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        button.addAction(UIAction(handler: { _ in
            var isFavorite = button.tintColor == .systemRed
            isFavorite.toggle()
            button.tintColor = isFavorite ? .systemRed : .lightGray
            self.favoriteHandler?()
        }), for: .touchUpInside)
        return button
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        return stackView
    }()

    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [stackView, favoriteButton])
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .top
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)

        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        NSLayoutConstraint.activate([
            containerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            containerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
        selectionStyle = .none
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private var favoriteHandler: (() -> Void)?

    func configure(post: Post, isFavorite: Bool, favoriteHandler: @escaping () -> Void) {
        titleLabel.text = post.title
        subtitleLabel.text = post.body
        favoriteButton.tintColor = isFavorite ? .systemRed : .lightGray
        self.favoriteHandler = favoriteHandler
    }
}
