//
//  NewsDetail.swift
//  newsApp
//
//  Created by MacBook on 1/23/21.
//

import SwiftUI

struct NewsDetail: View {
    var article:Article
    var body: some View {
        ScrollView {
            VStack {
                Text(article.title)
                    .font(.title)
                Divider()
                Text(article.content!)
            }
            
        }
        .navigationTitle(article.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct NewsDetail_Previews: PreviewProvider {
    static var previews: some View {
        NewsDetail(article: NewsService.shared.json.articles[0])
    }
}
