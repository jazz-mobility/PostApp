//
//  GetUser.swift
//  PostApp
//
//  Created by Jasveer Singh on 08.01.23.
//

struct GetUser: Request {
    typealias ReturnType = Users

    private let username: String

    init(username: String) {
        self.username = username
    }

    var path: String = "/users"

    var queryParams: [String : Any]? {
        ["username": username]
    }
}
