//
//  PostsViewController.swift
//  PostApp
//
//  Created by Jasveer Singh on 09.01.23.
//

import UIKit

/// @mockable
protocol PostsViewInterface: AnyObject {
    func show(error: String)
    func show(posts: Posts)
}

typealias PostsTableDataSource = UITableViewDiffableDataSource<Int, Post>

final class PostsViewController: UIViewController {
    private let tableView = UITableView()
    private let presenter: PostsPresenterInterface

    init(
        presenter: PostsPresenterInterface
    ) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var datasource: PostsTableDataSource = {
        let datasource = PostsTableDataSource(tableView: tableView) { tableView, indexPath, post in
            let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.reuseIdentifier, for: indexPath)
            if let cell = cell as? PostTableViewCell {
                cell.configure(post: post, isFavorite: true)
            }
            return cell
        }

        return datasource
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Posts"
        presenter.viewDidLoad()
    }

    override func loadView() {
        super.loadView()
        view = tableView
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.reuseIdentifier)
    }
}

extension PostsViewController: PostsViewInterface {
    func show(error: String) {
        showAlert(text: error)
    }

    func show(posts: Posts) {
        var snapshot = datasource.snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(posts, toSection: 0)
        datasource.apply(snapshot)
        tableView.reloadData()
    }
}
