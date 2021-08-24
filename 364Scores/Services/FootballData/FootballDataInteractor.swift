//
//  FootballDataInteractor.swift
//  364Scores
//
//  Created by Yohai Reshef on 23/08/2021.
//

import Foundation
import Combine

protocol FootballDataInteracting {
    func getTeam(id: String) -> AnyPublisher<Team, NetworkError>
    func getAllTeams() -> AnyPublisher<ManyTeamsResponse, NetworkError>
    func getMatches(forTeamID id: String, limit: Int) -> AnyPublisher<ManyMatchResponse, NetworkError>
}

enum FootballDataRoute: Route {
    
    private var path: String {
        "https://api.football-data.org/v2"
    }
    
    case team(id: String)
    case teams
    case getTeamMatches(id: String, limit: Int = 0)
    
    var urlPath: String {
        
        switch self {
        case .team(let id):
            return "\(path)/teams/\(id)"
        case .teams:
            return "\(path)/teams/"
        case .getTeamMatches(let id, _):
            return FootballDataRoute.team(id: id).urlPath + "/matches/"
        }
        
    }
    var parameters: [String : String] {
        switch self {
        
        case .getTeamMatches(_ , let limit):
            return ["limit":"\(limit)"]
        default:
            return [:]
        }
    }
}

class FootballDataInteractor: FootballDataInteracting {
    
    private let networkService: NetworkServicing
    
    init(networkService: NetworkServicing) {
        self.networkService = networkService
    }
    
    func getAllTeams() -> AnyPublisher<ManyTeamsResponse, NetworkError> {
        networkService.request(type: ManyTeamsResponse.self, route: .footballData(route: .teams))
    }
    
    func getTeam(id: String) -> AnyPublisher<Team, NetworkError> {
        networkService.request(type: Team.self, route: .footballData(route: .team(id: id)))
    }
    
    func getMatches(forTeamID id: String, limit: Int) -> AnyPublisher<ManyMatchResponse, NetworkError> {
        networkService.request(type: ManyMatchResponse.self, route: .footballData(route: .getTeamMatches(id: id, limit: limit)))
    }
}
