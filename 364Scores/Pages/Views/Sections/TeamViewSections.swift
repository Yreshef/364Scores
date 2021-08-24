//
//  TeamViewSections.swift
//  364Scores
//
//  Created by Yohai Reshef on 24/08/2021.
//

import Foundation

enum TeamsSections: Int, CaseIterable, CustomStringConvertible {
    
    case Logo
    case Squad
    case Fixtures
    
    var description: String {
        switch self {
        case .Logo:
            return "Logo"
        case .Squad:
            return "Squad"
        case .Fixtures:
            return "Fixtures"
        }
    }
}
