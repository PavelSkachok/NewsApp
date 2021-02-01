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

class NewsViewModel:NSObject, ObservableObject {
    @Published var userLatitude: Double = 0
    @Published var userLongitude: Double = 0
    @Published var currentCountry: String?
    private var placemark: CLPlacemark?
    var service = NewsService()
    @Published var newsArticles :[Article] = []
    @Published var sourcesNews: [Source] = []
    
    
    @Published var indexEndpoint: Int = 0
    @Published var stringEndpoint: String = "general"
    @Published var countryEndpoint: String = "ru"
    @Published var keyword:String = ""
    var cancellable: AnyCancellable?
    var cancellableSource:AnyCancellable?
    
    var indexIdNews: [UUID]{
        newsArticles.map{
            $0.id
        }
    }
    var stringIdNews: [String]{
        newsArticles.map{
            $0.url!
        }
    }
   
    private let locationManager = CLLocationManager()
    private let geoCoder = CLGeocoder()
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
        cancellable = Publishers.CombineLatest4($indexEndpoint, $stringEndpoint, $countryEndpoint,
                                                $keyword
                                                    .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
                                                    .eraseToAnyPublisher()
        )
            .flatMap{ (index, string, country, keyword) -> AnyPublisher<[Article], Error> in
                return self.service.fetchArticles(endpoint: Endpoints.init(index: index),stringEndpoints: string, countryEndpoint: country, keyword: keyword)
            }
        .sink(receiveCompletion: {
            error in
            self.newsArticles = []
            return print(error)
            
        }, receiveValue: { api in
            self.newsArticles = api
//            print("Проверка названия статьи: "+api.articles[0].title!)
        })
        
        cancellableSource = self.service.fetchSources()
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
    
    func geoCode(with location: CLLocation) {
        geoCoder.reverseGeocodeLocation(location){(placemark, error) in
            self.placemark = placemark?.last
        }
    }
}

extension NewsViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        guard let location = locations.first else {
            return
        }
        userLatitude = location.coordinate.latitude
        userLongitude = location.coordinate.longitude
        geoCode(with: location)
        currentCountry = placemark?.isoCountryCode
//        print("код страны"+(placemark?.isoCountryCode)!)
//        countryEndpoint = placemark?.isoCountryCode
        if currentCountry != nil {
            print("зашли в если")
            countryEndpoint = placemark?.isoCountryCode ?? "pasha"
            manager.stopUpdatingLocation()
        }
    }
}
