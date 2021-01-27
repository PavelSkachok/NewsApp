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
    
    func fetchArticles(endpoint: Endpoints, stringEndpoints: String, countryEndpoint: String)-> AnyPublisher<API,Error> {
        var components = URLComponents()
        components.path = "/v2/top-headlines"
        components.queryItems = [
            "country": countryEndpoint,
            "category": endpoint.path() == "" ? nil: stringEndpoints,
            "apiKey": "b2a849c07c30432eb9e293ee88c2117c",
        ]
        .compactMap {
            URLQueryItem(name: $0.key, value: $0.value)
            
        }
        let url = components.url(relativeTo: URL(string: "https://newsapi.org")!)
        let request = URLRequest(url: url!)
        print(request)
        return URLSession
            .shared
            .dataTaskPublisher(for: request)

            .tryMap {
                try  JSONDecoder().decode(API.self, from: $0.data)
        }
//            .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

}
