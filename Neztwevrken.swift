//
//  Neztwevrken.swift
//  star-wars-wiki
//
//  Created by Yohai Reshef on 01/08/2021.
//  Copyright © 2021 YReshef. All rights reserved.
//

import Foundation

enum NetworkResults<T: Decodable> {
    case success(result: T)
    case failure(error: Error)
}

class Neztwevrken {
    
    enum NetworkError: LocalizedError {
        case noData
        case requestFailed(status: Int), decodeFailure
        
        
        var errorDescription: String? {
            switch self {
            case .noData:
                return "Request successful, no data"
            case .requestFailed(let status):
                return "Request failed with status code: \(status)"
            case .decodeFailure:
                return "Failed to decode JSON"
           
            }
        }
    }
    
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func request<T>(type: T.Type, urlString: String, completion: @escaping (NetworkResults<T>) -> Void) where T: Decodable {
        let url = URL(string: urlString)!
        session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error: error))
                return
            }
            if let res = response as? HTTPURLResponse{
                guard 200...299 ~= res.statusCode else {
                    completion(.failure(error: NetworkError.requestFailed(status: res.statusCode)))
                    return
                }
            }
            guard let data = data else {
                completion(.failure(error: NetworkError.noData))
                return
            }
            let decode = JSONDecoder()
            guard let result = try? decode.decode(T.self, from: data) else {
                completion(.failure(error: NetworkError.decodeFailure))
                return
            }
            completion(.success(result: result))
        }.resume()
    }
}
