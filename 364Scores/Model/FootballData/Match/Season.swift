//
//  Season.swift
//  364Scores
//
//  Created by Yohai Reshef on 25/08/2021.
//

import Foundation

struct Season: Decodable {
    var id: Int
    var startDate: String?
    var endDate: String?
    var currentMatchday: Int?
    var winner: String?
}
