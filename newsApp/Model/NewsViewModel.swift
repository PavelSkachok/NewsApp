//
//  NewsViewModel.swift
//  newsApp
//
//  Created by MacBook on 1/26/21.
//

import Foundation
import Combine

class NewsViewModel: ObservableObject{
    var service = NewsService()
//    var locationViewModel = LocationViewModel()
    @Published var newsApi :API?
    @Published var indexEndpoint: Int = 1
    @Published var stringEndpoint: String = "general"
    @Published var countryEndpoint: String = LocationViewModel().currentCountry ?? "ru"
    var cancellable: AnyCancellable?
   
    
    init() {
        cancellable = Publishers.CombineLatest3($indexEndpoint, $stringEndpoint, $countryEndpoint)
            .flatMap{ (index, string, country) -> AnyPublisher<API, Error> in
                return self.service.fetchArticles(endpoint: Endpoints.init(index: index),stringEndpoints: string, countryEndpoint: country)
            }
        .sink(receiveCompletion: {
            error in
            return print(error)
        }, receiveValue: { api in
            self.newsApi = api
            print("Проверка названия статьи: "+api.articles[0].title!)
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
