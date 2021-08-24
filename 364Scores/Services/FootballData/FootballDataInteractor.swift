//
//  FootballDataInteractor.swift
//  364Scores
//
//  Created by Yohai Reshef on 23/08/2021.
//

import Foundation
import Combine

protocol FootballDataInteracting {
//    func request(completion: @escaping (NetworkResult<Team>) -> Void)
    func getTeam(id: String) -> AnyPublisher<Team, NetworkError>
    func getAllTeams() -> AnyPublisher<ManyTeamsResponse, NetworkError>
}

enum FootballDataRoute: Route {
    
    private var path: String {
        "https://api.football-data.org/v2"
    }
    
    case team(id: String)
    case teams
    
    var urlPath: String {
        switch self {
        case .team(let id):
            return "\(path)/teams/\(id)"
        case .teams:
            return "\(path)/teams/"
        }
      
    }
}

class FootballDataInteractor: FootballDataInteracting {
    
    private let networkService: NetworkServicing
    
    init(networkService: NetworkServicing) {
        self.networkService = networkService
    }
    
//    func request(completion: @escaping (NetworkResult<Team>) -> Void) {
//        networkService.request(type: Team.self, route: .footballData(route: .team(id: "1")), completion: completion)
//    }
    
    func getAllTeams() -> AnyPublisher<ManyTeamsResponse, NetworkError> {
        networkService.request(type: ManyTeamsResponse.self, route: .footballData(route: .teams))
    }
    
    func getTeam(id: String) -> AnyPublisher<Team, NetworkError> {
        networkService.request(type: Team.self, route: .footballData(route: .team(id: id)))
    }
}
