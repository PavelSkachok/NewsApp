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

struct Param{
    var index:Int = 0
    var category: String = "general"
    var country: String = "ru"
    var keywordOrb: String = ""
    var source:String = "all"
}


class NewsViewModel:NSObject, ObservableObject {
    @Published var userLatitude: Double = 0
    @Published var userLongitude: Double = 0
    @Published var currentCountry: String?
    private var placemark: CLPlacemark?
    var service = NewsService()
    @Published var newsArticles :[Article] = []
    
    
    @Published var indexEndpoint: Int = 0
    @Published var categoryEndpoint: String = "general"
    @Published var countryEndpoint: String = "ru"
    @Published var source:String = ""
    @Published var keyword:String = ""
    var cancellableSet: Set<AnyCancellable> = []
    var cancellable:AnyCancellable?
    @Published var param:Param = Param()
    
    
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
   
    init(source: String) {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
//                fetchData()
        
        self.param.source = source
        fetchData2()
       
        
    }
    
    
    func fetchData(){
        cancellable = Publishers.CombineLatest4( $indexEndpoint, $categoryEndpoint, $countryEndpoint,
                                                $keyword
                                                    .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
                                                    .eraseToAnyPublisher()
        )
        .flatMap{ (index, string, country, keyword) -> AnyPublisher<[Article], Error> in
                return self.service.fetchArticles(endpoint: Endpoints.init(index: index),stringEndpoints: string, countryEndpoint: country, keyword: keyword, source: "all")
            }
        .sink(receiveCompletion: {
            error in
            self.newsArticles = []
            return print(error)
            
        }, receiveValue: { api in
            self.newsArticles = api
        })
    }
    
    func fetchData2(){
      cancellable = $param
        .flatMap{
            return  self.service.fetchArticles(endpoint: Endpoints.init(index: $0.index), stringEndpoints: $0.category, countryEndpoint: $0.country, keyword: $0.keywordOrb,source: $0.source)
        }
        .sink(receiveCompletion: {
            error in
            self.newsArticles = []
            return print(error)

        }, receiveValue: { api in
            self.newsArticles = api
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
        if currentCountry != nil {
            print("зашли в если")
            countryEndpoint = placemark?.isoCountryCode ?? "pasha"
            param.country = placemark?.isoCountryCode ?? "pasha"
            manager.stopUpdatingLocation()
        }
    }
}
