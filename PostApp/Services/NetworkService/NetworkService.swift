//
//  NetworkService.swift
//  PostApp
//
//  Created by Jasveer Singh on 08.01.23.
//

import Foundation
import Combine

protocol Networking {
    func execute<R: Request>(_ request: R) -> AnyPublisher<R.ReturnType, NetworkError>
}

final class NetworkService {
    private static let jsonDecoder = JSONDecoder()
    private let urlSession: URLSession
    private let baseURLString: String

    init(
        urlSession: URLSession = .shared,
        baseURLString: String
    ) {
        self.urlSession = urlSession
        self.baseURLString = baseURLString
    }
}

extension NetworkService: Networking {
    func execute<R: Request>(_ request: R) -> AnyPublisher<R.ReturnType, NetworkError> {
        guard let request = try? request.asURLRequest(baseURLString) else {
            return Fail(outputType: R.ReturnType.self, failure: NetworkError.badRequest).eraseToAnyPublisher()
        }

        return urlSession
            .dataTaskPublisher(for: request)
            .tryMap( { data, response in
                if let response = response as? HTTPURLResponse,
                   !(200...299).contains(response.statusCode) {
                    throw self.httpError(response.statusCode)
                }

                return data
            })
            .decode(type: R.ReturnType.self, decoder: Self.jsonDecoder)
            .mapError { error in
                self.handleError(error)
            }
            .eraseToAnyPublisher()
    }
}

private extension NetworkService {
     func httpError(_ statusCode: Int) -> NetworkError {
        switch statusCode {
            case 400: return .badRequest
            case 401: return .unauthorized
            case 403: return .forbidden
            case 404: return .notFound
            case 402, 405...499: return .error4xx(statusCode)
            case 500: return .serverError
            case 501...599: return .error5xx(statusCode)
            default: return .unknownError
        }
    }

    func handleError(_ error: Error) -> NetworkError {
        switch error {
            case is Swift.DecodingError:
                return .decodingError
            case let urlError as URLError:
                return .urlSessionFailed(urlError)
            case let error as NetworkError:
                return error
            default:
                return .unknownError
        }
    }
}
