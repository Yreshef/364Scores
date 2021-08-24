//
//  Matches.swift
//  364Scores
//
//  Created by Yohai Reshef on 24/08/2021.
//

import Foundation

struct Competition: Decodable{
    var id: Int
    var name: String?
}

struct Season: Decodable {
    var id: Int
    var startDate: String?
    var endDate: String?
    var currentMatchday: Int?
    var winner: String?
}

struct Score: Decodable {
    var winner: String?
    var duration: String?
    var fullTime: Game
    
}

struct Game: Decodable {
    var homeTeam: String?
    var awayTeam: String?
}

struct MatchTeam: Decodable {
    var id: Int
    var name: String?
}


struct Match: Decodable{
    var id: Int
    var season: Season
    var utcDate: String?
    var status: String?
    var matchday: Int?
    var stage: String?
    var group: String?
    var lastUpdated: String?
    var score: Score
    var halfTime: Game
    var extraTime: Game
    var penalties: Game
    var homeTeam: MatchTeam
    var awayTeam: MatchTeam
}

