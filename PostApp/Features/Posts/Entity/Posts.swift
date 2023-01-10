//
//  Posts.swift
//  PostApp
//
//  Created by Jasveer Singh on 09.01.23.
//

import Foundation

struct Post: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

extension Post: Hashable {}

typealias Posts = [Post]
