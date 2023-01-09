//
//  Endpoint.swift
//  PostApp
//
//  Created by Jasveer Singh on 08.01.23.
//

import Foundation

public enum HTTPMethod: String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case delete  = "DELETE"
}

public protocol Request {
    var path: String { get }
    var method: HTTPMethod { get }
    var contentType: String { get }
    var queryParams: [String: String]? { get }
    var body: [String: Any]? { get }
    var headers: [String: String]? { get }

    associatedtype ReturnType: Decodable
}

// MARK: - Default Request
extension Request {
    var method: HTTPMethod { return .get }
    var contentType: String { return "application/json" }
    var queryParams: [String: String]? { return nil }
    var body: [String: Any]? { return nil }
    var headers: [String: String]? { return nil }
}

extension Request {
    private func requestBodyFrom(params: [String: Any]?) -> Data? {
        guard let params = params else { return nil }
        guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else {
            return nil
        }
        return httpBody
    }

    func asURLRequest(_ baseURLString: String) throws -> URLRequest? {
        guard var urlComponents = URLComponents(string: baseURLString) else { throw NetworkError.invalidRequest }

        urlComponents.path = path
        if let queryItems = queryParams?
            .map({ URLQueryItem(name: $0, value: $1) }) {
            urlComponents.queryItems = queryItems
        }

        guard let finalURL = urlComponents.url else { throw NetworkError.invalidRequest }

        var request = URLRequest(url: finalURL)
        request.httpMethod = method.rawValue
        request.httpBody = requestBodyFrom(params: body)
        request.allHTTPHeaderFields = headers
        return request
    }
}
