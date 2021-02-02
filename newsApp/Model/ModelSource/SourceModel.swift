//
//  NewsViewModel.swift
//  newsApp
//
//  Created by MacBook on 1/26/21.
//

import Foundation
import Combine
import SwiftUI
import CoreLocation

class SourceModel: ObservableObject {
    var service = SourceService()
    @Published var sourcesNews: [Source] = []
    @Published var pathNews:String = "/v2/sources"
    @Published var country:String = "all"
    @Published var category:String = "all"
    
    @Published var indexEndpoint: Int = 0
    @Published var stringEndpoint: String = "general"
    @Published var countryEndpoint: String = "ru"
    @Published var keyword:String = ""
    var cancellable: AnyCancellable?
    

    init() {
        cancellable = Publishers.CombineLatest($country,$category)
            .flatMap{(country,category) -> AnyPublisher<[Source],Error> in
                return self.service.fetchSources(country:country,category: category)
            }
//            .debounce(for: .seconds(3), scheduler: DispatchQueue.main)
            .sink(receiveCompletion: {
                error in
                self.sourcesNews = []
                print("ошибка декодирования источников")
                print(error)
            }, receiveValue: {
                apisource in
                self.sourcesNews = apisource
            })
    }
}
