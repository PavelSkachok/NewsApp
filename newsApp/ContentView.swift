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
    @ObservedObject var news = NewsViewModel()
//    @ObservedObject var test = Test()
    var body: some View {
        if let a = news.newsApi {
            
            VStack {
                Picker("",selection: $news.indexEndpoint) {
                    Text("topHeadlines").tag(0)
                    Text("Category").tag(1)
                }.pickerStyle(SegmentedPickerStyle())
                
                if news.indexEndpoint == 1 {
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
                }
                NewsList(articles: a.articles)
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
