//
//  Routes.swift
//  364Scores
//
//  Created by Yohai Reshef on 23/08/2021.
//

import Foundation

protocol Route {
    var urlPath: String { get }
    var parameters: [String:String] { get }
}

enum NetworkRoutes: Route {
   
    case footballData(route: FootballDataRoute)
    
    var urlPath: String {
        switch self {
        case .footballData(let route):
            return route.urlPath
        }
    }
    
    var parameters: [String : String] {
        switch self {
        case .footballData(let route):
            return route.parameters
        }
    }
}
