//
//  GetUser.swift
//  PostApp
//
//  Created by Jasveer Singh on 08.01.23.
//

import Foundation

struct GetUser: Request {
    typealias ReturnType = [User]

    private let username: String

    init(username: String) {
        self.username = username
    }

    var path: String = "/users"
    var queryParams: [String : String]? {
        ["username": username]
    }
}
