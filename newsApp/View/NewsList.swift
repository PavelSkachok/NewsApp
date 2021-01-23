//
//  NewsList.swift
//  newsApp
//
//  Created by MacBook on 1/23/21.
//

import SwiftUI

struct NewsList: View {
    var articles: [Article]
    var body: some View {
        NavigationView {
            List(articles){article in
                NavigationLink(destination: NewsDetail(article: article)) {
                    NewsRow(article: article)
                }
            }
            .navigationTitle("News")
        }
    }
}

struct NewsList_Previews: PreviewProvider {
    static var previews: some View {
        NewsList(articles: NewsService.shared.json.articles)
    }
}
