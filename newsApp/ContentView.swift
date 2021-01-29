//
//  ContentView.swift
//  newsApp
//
//  Created by MacBook on 1/23/21.
//

import SwiftUI
import Combine

class Test: ObservableObject {
    @Published var count: Int = 0
    @Published var present: Int = 0
    var cancellable: AnyCancellable?
    init(){
        cancellable = $count
            .sink(receiveValue:{
                self.present = $0
            })
            
//        print("\(count)")
    }
}



struct ContentView: View {
   
//    @ObservedObject var local = LocationViewModel()
    @ObservedObject var news = NewsViewModel()
    
    var body: some View {
        
        if  let articles = news.newsArticles {
            VStack {
//                Text(LocationViewModel.currentCountry ?? "Pasha")
                Text(news.countryEndpoint)
               Picker("",selection: $news.indexEndpoint) {
                    Text("topHeadlines").tag(0)
                    Text("everything").tag(1)
                }.pickerStyle(SegmentedPickerStyle())
                TextField("Search", text: $news.keyword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
    
                Text("Category")
                    Picker("", selection: $news.stringEndpoint) {
                        Text("business").tag("business")
                        Text("entertainment").tag("entertainment")
                        Text("general").tag("general")
                    }.pickerStyle(SegmentedPickerStyle())
                    Picker("", selection: $news.stringEndpoint) {
                        Text("health").tag("health")
                        Text("science").tag("science")
                        Text("sports").tag("sports")
                        Text("technology").tag("technology")
                    }.pickerStyle(SegmentedPickerStyle())
                Text("Country")
                Picker("",selection: $news.countryEndpoint) {
                    Text("cz").tag("cz")
                    Text("de").tag("de")
                    Text("pl").tag("pl")
                    Text("ru").tag("ru")
                    Text("ua").tag("ua")
                    Text("us").tag("us")
                    Text("fr").tag("fr")
                    Text("gb").tag("gb")
                }.pickerStyle(SegmentedPickerStyle())
                NewsList(articles: articles)
            }
        }
        else {
            Text("null")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
