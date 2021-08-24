//
//  Player.swift
//  364Scores
//
//  Created by Yohai Reshef on 23/08/2021.
//

import Foundation

struct Player: Decodable{
    var id: Int
    var name: String?
    var firstName: String?
    var lastName: String?
    var dateOfBirth: String?
    var countryOfBirth: String?
    var nationality: String?
    var position: String?
    var lastUpdated: String?
    var role: String?
}

