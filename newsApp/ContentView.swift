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
                Picker("", selection: $news.indexEndpoint) {
                    Text("business").tag(0)
                    Text("entertainment").tag(1)
                    Text("general").tag(2)
                }.pickerStyle(SegmentedPickerStyle())
                Picker("", selection: $news.indexEndpoint) {
                    Text("health").tag(3)
                    Text("science").tag(4)
                    Text("sports").tag(5)
                    Text("technology").tag(6)
                }.pickerStyle(SegmentedPickerStyle())
                Text(Endpoints(index: news.indexEndpoint).path())
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
