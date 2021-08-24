//
//  Team.swift
//  364Scores
//
//  Created by Yohai Reshef on 23/08/2021.
//

import Foundation

struct Team: Decodable{
    var id: Int
    var area: Area?
    var name: String?
    var shortName: String?
    var tla: String?
    var crestUrl: String?
    var address: String?
    var phone: String?
    var website: String?
    var email: String?
    var founded: Int?
    var clubColors: String?
    var venue: String?
    var squad: [Player]?
    var lastUpdated: String?
}
