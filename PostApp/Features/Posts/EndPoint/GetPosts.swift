//
//  GetPosts.swift
//  PostApp
//
//  Created by Jasveer Singh on 10.01.23.
//

import Foundation

struct GetPosts: Request {
    typealias ReturnType = Posts

    private let userId: Int

    init(userId: Int) {
        self.userId = userId
    }

    var path: String = "/posts"

    var queryParams: [String : Any]? {
        ["userId": userId]
    }
}
