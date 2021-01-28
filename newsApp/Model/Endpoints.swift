//
//  Endpoints.swift
//  newsApp
//
//  Created by MacBook on 1/27/21.
//

import Foundation
enum Endpoints{
    case topHeadlines
    case everything
    
    init(index: Int){
        switch index {
        case 0:
            self = .topHeadlines
        case 1:
            self = .everything
       
            
        default:
            self = .topHeadlines
        }
    }
    
    func path() -> String{
        switch self {
        case .topHeadlines:
            return "/v2/top-headlines"
        case .everything:
            return "/v2/everything"
        }
    }
}
