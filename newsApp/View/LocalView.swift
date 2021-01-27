//
//  LocalView.swift
//  newsApp
//
//  Created by MacBook on 1/27/21.
//

import SwiftUI

struct LocalView: View {
    @ObservedObject var locationViewModel = LocationViewModel()
    var body: some View {
        VStack{
            Text("Your location is:")
            HStack{
                Text("Latitude: \(locationViewModel.userLatitude)")
                Text("Longitude: \(locationViewModel.userLongitude)")
            }
            Text("Country: \(locationViewModel.currentCountry ?? "Pasha")")
        }
    }
}

struct LocalView_Previews: PreviewProvider {
    static var previews: some View {
        LocalView()
    }
}
