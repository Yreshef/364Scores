//
//  HomeScreenSections.swift
//  364Scores
//
//  Created by Yohai Reshef on 23/08/2021.
//

import Foundation

enum HomeScreenSections: Int, CaseIterable, CustomStringConvertible {
    
    case Teams
    
    var description: String {
        switch self {
        case .Teams:
            return "Teams"
        }
    }
}




