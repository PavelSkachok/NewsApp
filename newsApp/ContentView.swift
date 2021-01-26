//
//  ContentView.swift
//  newsApp
//
//  Created by MacBook on 1/23/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var news = NewsViewModel()
    var body: some View {
        if let a = news.newsApi {
            ZStack{
                NewsList(articles: a.articles)
            }
        }else {
            Text("null")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
