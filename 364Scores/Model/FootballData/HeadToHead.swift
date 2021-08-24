//
//  HeadToHead.swift
//  364Scores
//
//  Created by Yohai Reshef on 24/08/2021.
//

import Foundation

struct HeadToHead: Decodable {
    var numberOfMatches: Int
    var totalGoals: Int
    var homeTeam: TeamStats
    
    var awayTeam: TeamStats

}

struct TeamStats: Decodable {
    var wins: Int?
    var draws: Int?
    var losses: Int?
}
