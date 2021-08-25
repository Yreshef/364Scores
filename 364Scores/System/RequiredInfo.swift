//
//  RequiredInfo.swift
//  364Scores
//
//  Created by Yohai Reshef on 25/08/2021.
//

import Foundation

//This is used for convenience sake for the excersize. In production api
// keys should not be saved on client side
enum RequiredInfo: CustomStringConvertible {

    case apiKey
    case authTokenHeader
    
    var description: String {
        switch self {
        case .apiKey:
            return "a741aa4da6f44a20b9e96ebc013721ea"
        case .authTokenHeader:
            return "X-Auth-Token"
        }
    }
   
}
