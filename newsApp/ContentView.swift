//
//  ContentView.swift
//  newsApp
//
//  Created by MacBook on 1/23/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            NewsList(articles: NewsService.shared.json.articles)
           
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
