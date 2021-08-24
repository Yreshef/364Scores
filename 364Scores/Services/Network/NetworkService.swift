//
//  NetworkService.swift
//  364Scores
//
//  Created by Yohai Reshef on 23/08/2021.
//

import Foundation
import Combine

protocol NetworkServicing {
    func request<T>(type:T.Type, route: NetworkRoutes) -> AnyPublisher<T, NetworkError> where T: Decodable
}

enum NetworkResult<T: Decodable> {
    case success(result: T)
    case failure(error: Error)
}

enum NetworkError: LocalizedError {
    case noData
    case requestFailure(status: Int)
    case decodingFailure(error: Error)
    case invalidURL
    case invalidResponse
}

// MARK: - Network Service

class NetworkService: NetworkServicing {
    private let session: URLSession
    
    //TODO: Move to enum in system file and make sure its obvious this is not the way it should be
    private var apiKey: String {
        "a741aa4da6f44a20b9e96ebc013721ea"
    }

    private var authHeader: String {
        return "X-Auth-Token"
    }
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func request<T>(type:T.Type, route: NetworkRoutes) -> AnyPublisher<T, NetworkError> where T: Decodable {
        var components = URLComponents(string: route.urlPath)
        components?.queryItems = route.parameters.map({
            return URLQueryItem(name: $0.key, value: $0.value)
        })
        guard let url = components?.url else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue(apiKey, forHTTPHeaderField: authHeader)
        return session
            .dataTaskPublisher(for: urlRequest)
            .tryMap { response -> Data in
                guard let res = response.response as? HTTPURLResponse else {
                    throw NetworkError.invalidResponse
                }
                guard 200...299 ~= res.statusCode else {
                    throw NetworkError.requestFailure(status: res.statusCode)
                }
                return response.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                NetworkError.decodingFailure(error: error)
            }
            .eraseToAnyPublisher()
    }
}
