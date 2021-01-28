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
    @Published var newsApi :API?
    @Published var indexEndpoint: Int = 1
    @Published var stringEndpoint: String = "general"
    @Published var countryEndpoint: String = "ru"
    var cancellable: AnyCancellable?
   
    private let locationManager = CLLocationManager()
    private let geoCoder = CLGeocoder()
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
        cancellable = Publishers.CombineLatest3($indexEndpoint, $stringEndpoint, $countryEndpoint)
            .flatMap{ (index, string, country) -> AnyPublisher<API, Error> in
                return self.service.fetchArticles(endpoint: Endpoints.init(index: index),stringEndpoints: string, countryEndpoint: country)
            }
        .sink(receiveCompletion: {
            error in
            return print(error)
        }, receiveValue: { api in
            self.newsApi = api
//            print("Проверка названия статьи: "+api.articles[0].title!)
        })
    }
    
    func geoCode(with location: CLLocation) {
        geoCoder.reverseGeocodeLocation(location){(placemark, error) in
            self.placemark = placemark?.last
        }
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
