//
//  GetManyResponse.swift
//  364Scores
//
//  Created by Yohai Reshef on 23/08/2021.
//

import Foundation

struct ManyTeamsResponse: Decodable {
    var count: Int?
    var teams: [Team]?
}
