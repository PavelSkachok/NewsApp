//
//  NewsService.swift
//  newsApp
//
//  Created by MacBook on 1/23/21.
//

import Foundation
import Combine

class NewsService {
    static let shared = NewsService()
    
    
    
    var json: API {
        let decoder = JSONDecoder()
        let url = Bundle.main.url(forResource: "NewsResponse",withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return try! decoder.decode(API.self, from: data)
    }
    
    func fetchArticles()-> AnyPublisher<API,Error> {
        print("Publisher input")
        var components = URLComponents()
        components.path = "/v2/top-headlines"
        components.queryItems = [
            "country": "ru",
            "apiKey": "751b73924a1a42b88d7ba11f1b04ed3b",
        ]
        .compactMap {
            URLQueryItem(name: $0.key, value: $0.value)
            
        }
        let url = components.url(relativeTo: URL(string: "https://newsapi.org")!)
        let request = URLRequest(url: url!)
        return URLSession
            .shared
            .dataTaskPublisher(for: request)
            .tryMap {
                try  JSONDecoder().decode(API.self, from: $0.data)
        }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }

}
