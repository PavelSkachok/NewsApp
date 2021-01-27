//
//  Endpoints.swift
//  newsApp
//
//  Created by MacBook on 1/27/21.
//

import Foundation
enum Endpoints{
    case business
    case entertainment
    case general
    case health
    case science
    case sports
    case technology
    
    init(index: Int){
        switch index {
        case 0:
            self = .business
        case 1:
            self = .entertainment
        case 2:
            self = .general
        case 3:
            self = .health
        case 4:
            self = .science
        case 5:
            self = .sports
        case 6:
            self = .technology
        default:
            self = .general
            
        }
    }
    
    func path() -> String{
        switch self {
        case .business:
            return "business"
        case .entertainment:
            return "entertainment"
        case .general:
            return "general"
        case .health:
            return "health"
        case .science:
            return "science"
        case .sports:
            return "sports"
        case .technology:
            return "technology"
        }
    }
}
