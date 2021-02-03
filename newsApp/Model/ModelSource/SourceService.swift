//
//  NewsService.swift
//  newsApp
//
//  Created by MacBook on 1/23/21.
//

import Foundation
import Combine

class SourceService {
    static let shared = SourceService()
    
    var jsonSource: APISources {
        let decoder = JSONDecoder()
        let url = Bundle.main.url(forResource: "SourcesResponse",withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return try! decoder.decode(APISources.self, from: data)
    }
    
    func fetchSources(country: String, category: String)-> AnyPublisher<[Source],Error> {
        var components = URLComponents()
        components.path = "/v2/sources"
        components.queryItems = [
//            "q": keyword,
            "country": country == "all" ? nil: country,
            "category": category == "all" ? nil:category,
//          "apiKey": "b2a849c07c30432eb9e293ee88c2117c",
//          "apiKey": "7cfca023b0f7404bb6474a2797e7dfc0",
//            "apiKey": "751b73924a1a42b88d7ba11f1b04ed3b",
//            "apiKey": "3a807e689d1444b3a1aab06e68f5ceb8",
            "apiKey": "69e092f2ff5544809589426108a11c77",
//            "apiKey": "f032808cd7274be987d2306bbdeadc0b",
        ]
        .compactMap {
            URLQueryItem(name: $0.key, value: $0.value)
            
        }
        let url = components.url(relativeTo: URL(string: "https://newsapi.org")!)
        let request = URLRequest(url: url!)
        print("Запрос источников: \(request)")
        return URLSession
            .shared
            .dataTaskPublisher(for: request)
            .map{$0.data}
//            .decode(type: [Source].self, decoder: JSONDecoder)
            .tryMap {
                print("момент перед декодированием источников")
                print($0)
                do{
                    print("декодирование")
                    return try JSONDecoder().decode(APISources.self, from: $0).sources
                }
                   catch{
                    print("Ошибка из catch \(error)")
                    return []
                }
                }
//            .debounce(for: 1, scheduler: DispatchQueue.main)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }


}
