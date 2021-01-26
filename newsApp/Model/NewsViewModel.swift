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
    var cancellable: AnyCancellable?
    var service = NewsService()
    
    init() {
        print("Initial")
        fetchNewsApi()
    }
    
    func fetchNewsApi(){
        print("Subscribe input")
        cancellable = service.fetchArticles()
            .sink(receiveCompletion: {
               _ in
            }, receiveValue: {api in
                self.newsApi = api
            })
    }
}
