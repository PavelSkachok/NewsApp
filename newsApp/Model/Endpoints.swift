//
//  Endpoints.swift
//  newsApp
//
//  Created by MacBook on 1/27/21.
//

import Foundation
enum Endpoints{
    case topHeadlines
    case category
    
    init(index: Int){
        switch index {
        case 0:
            self = .topHeadlines
        case 1:
            self = .category
       
            
        default:
            self = .topHeadlines
        }
    }
    
    func path() -> String{
        switch self {
        case .topHeadlines:
            return ""
        case .category:
            return "general"
        }
    }
}
