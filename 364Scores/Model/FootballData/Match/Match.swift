//
//  Matches.swift
//  364Scores
//
//  Created by Yohai Reshef on 24/08/2021.
//

import Foundation

struct Match: Decodable{
    var id: Int
    var competition: Competition
    var season: Season
    var utcDate: String?
    var status: String?
    var matchday: Int?
    var stage: String?
    var group: String?
    var lastUpdated: String?
    var score: Score
    var homeTeam: MatchTeam
    var awayTeam: MatchTeam
}

