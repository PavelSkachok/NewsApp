//
//  NewsViewModel.swift
//  newsApp
//
//  Created by MacBook on 1/26/21.
//

import Foundation
import Combine

class NewsViewModel: ObservableObject {
    @Published var newsApi :API?
    @Published var indexEndpoint: Int = 0
    @Published var stringEndpoint: String = "general"
    var cancellable: AnyCancellable?
    var service = NewsService()
    
    init() {
        cancellable = Publishers.CombineLatest($indexEndpoint,$stringEndpoint)
            .flatMap{ (index, string) -> AnyPublisher<API, Error> in
                return self.service.fetchArticles(endpoint: Endpoints.init(index: index),stringEndpoints: string)
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
