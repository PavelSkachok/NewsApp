//
//  LocationViewModel.swift
//  newsApp
//
//  Created by MacBook on 1/27/21.
//

import Foundation
import Combine
import CoreLocation

class LocationViewModel: NSObject, ObservableObject{
    @Published var userLatitude: Double = 0
    @Published var userLongitude: Double = 0
    @Published var currentCountry: String?
    private var placemark: CLPlacemark?
    
    private let locationManager = CLLocationManager()
    private let geoCoder = CLGeocoder()
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    func geoCode(with location: CLLocation) {
        geoCoder.reverseGeocodeLocation(location){(placemark, error) in
            self.placemark = placemark?.last
        }
    }
}
extension LocationViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        guard let location = locations.last else {
            return
        }
        userLatitude = location.coordinate.latitude
        userLongitude = location.coordinate.longitude
        geoCode(with: location)
        currentCountry = placemark?.isoCountryCode
        print(location)
    }
}
