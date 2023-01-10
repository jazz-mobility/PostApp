//
//  Posts.swift
//  PostApp
//
//  Created by Jasveer Singh on 09.01.23.
//

import Foundation

struct Post: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

extension Post: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(userId)
    }
}

extension Post: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id && lhs.userId == rhs.userId
    }
}

typealias Posts = [Post]
