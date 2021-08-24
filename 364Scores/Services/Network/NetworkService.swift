//
//  NetworkService.swift
//  364Scores
//
//  Created by Yohai Reshef on 23/08/2021.
//

import Foundation
import Combine

protocol NetworkServicing {
//    func request<T>(type: T.Type, route: NetworkRoutes, completion: @escaping (NetworkResult<T>) -> Void)
    
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
    
    //TODO: Move elsewhere
    private var apiKey: String {
        "a741aa4da6f44a20b9e96ebc013721ea"
    }

    private var authHeader: String {
        return "X-Auth-Token"
    }
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
//    func request<T>(type: T.Type, route: NetworkRoutes, completion: @escaping (NetworkResult<T>) -> Void) where T: Decodable {
//        guard let url = URL(string: route.urlPath) else {
//            completion(.failure(error: NetworkError.invalidURL))
//            return
//        }
//        var urlRequest = URLRequest(url: url)
//        urlRequest.addValue(apiKey, forHTTPHeaderField: authHeader)
//        session.dataTask(with: urlRequest) { data, response, error in
//            if let error = error {
//                completion(.failure(error: error))
//                return
//            }
//            if let res = response as? HTTPURLResponse {
//                guard 200...299 ~= res.statusCode else {
//                    completion(.failure(error: NetworkError.requestFailure(status: res.statusCode)))
//                    return
//                }
//            }
//            guard let data = data else {
//                completion(.failure(error: NetworkError.noData))
//                return
//            }
//            let decode = JSONDecoder()
//            do {
//                let result = try decode.decode(T.self, from: data)
//                completion(.success(result: result))
//            } catch {
//                print("Error decoding data: \(error)")
//                completion(.failure(error: NetworkError.decodingFailure(error:)))
//            }
//        }.resume()
//    }
    
    func request<T>(type:T.Type, route: NetworkRoutes) -> AnyPublisher<T, NetworkError> where T: Decodable {
        guard let url = URL(string: route.urlPath) else {
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
