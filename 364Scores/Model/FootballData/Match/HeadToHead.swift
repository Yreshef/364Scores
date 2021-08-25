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


