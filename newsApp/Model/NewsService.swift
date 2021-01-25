//
//  NewsService.swift
//  newsApp
//
//  Created by MacBook on 1/23/21.
//

import Foundation

final class NewsService: ObservableObject {
    static let shared = NewsService()
    
    var json: API {
        let decoder = JSONDecoder()
        let url = Bundle.main.url(forResource: "NewsResponse",withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return try! decoder.decode(API.self, from: data)
    }
    
    
}
