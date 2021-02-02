//
//  ContentViewSources.swift
//  newsApp
//
//  Created by MacBook on 2/1/21.
//

import SwiftUI

struct ContentViewSources: View {
//    @EnvironmentObject var newsViewModel : NewsViewModel
    @ObservedObject var sourceModel = SourceModel()
//    var sources:[Source]
    var body: some View {
        Text("Category")
        Picker("", selection: $sourceModel.category) {
                Text("all").tag("all")
                Text("business").tag("business")
                Text("entertainment").tag("entertainment")
                Text("general").tag("general")
            }.pickerStyle(SegmentedPickerStyle())
        Picker("", selection: $sourceModel.category) {
                Text("health").tag("health")
                Text("science").tag("science")
                Text("sports").tag("sports")
                Text("technology").tag("technology")
            }.pickerStyle(SegmentedPickerStyle())
        Text("Country")
        Picker("",selection: $sourceModel.country) {
            Text("de").tag("de")
            Text("ru").tag("ru")
            Text("us").tag("us")
            Text("fr").tag("fr")
            Text("gb").tag("gb")
            Text("all").tag("all")
        }.pickerStyle(SegmentedPickerStyle())
        
        SourceList(sources: sourceModel.sourcesNews)
            .navigationBarTitle("Sources")
    }
}

struct ContentViewSources_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewSources()
    }
}
