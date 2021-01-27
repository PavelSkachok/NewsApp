//
//  NewsViewModel.swift
//  newsApp
//
//  Created by MacBook on 1/26/21.
//

import Foundation
import Combine

class NewsViewModel: ObservableObject {
    var service = NewsService()
    @Published var newsApi :API? = NewsService.shared.json
    @Published var indexEndpoint: Int = 0
    @Published var stringEndpoint: String = "general"
    @Published var countryEndpoint: String = "cz"
    var cancellable: AnyCancellable?
   
    
    init() {
        cancellable = Publishers.CombineLatest3($indexEndpoint, $stringEndpoint, $countryEndpoint)
            .flatMap{ (index, string, country) -> AnyPublisher<API, Error> in
                return self.service.fetchArticles(endpoint: Endpoints.init(index: index),stringEndpoints: string, countryEndpoint: country)
            }
        .sink(receiveCompletion: {
            _ in
        }, receiveValue: { api in
            self.newsApi = api
        })
    }
    
//    func fetchNewsApi(endpoint: Endpoints){
//        print("Subscribe input")
//        cancellable = service.fetchArticles(endpoint: endpoint)
//            .sink(receiveCompletion: {
//               _ in
//            }, receiveValue: {api in
//                self.newsApi = api
//            })
//    }
}
