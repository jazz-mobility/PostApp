//
//  NetworkError.swift
//  PostApp
//
//  Created by Jasveer Singh on 08.01.23.
//

import Foundation

enum NetworkError: LocalizedError, Equatable {
    case invalidRequest
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case error4xx(_ code: Int)
    case serverError
    case error5xx(_ code: Int)
    case decodingError
    case urlSessionFailed(_ error: URLError)
    case unknownError
}
