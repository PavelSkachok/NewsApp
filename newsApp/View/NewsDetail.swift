//
//  NewsDetail.swift
//  newsApp
//
//  Created by MacBook on 1/23/21.
//

import SwiftUI
import WebKit



struct NewsDetail: View {

    @EnvironmentObject var newsViewModel: NewsViewModel
//    var indexArticle: Int {
//
//    }
    var article: Article
//    var article:Article {
//        newsViewModel.newsArticles[indexArticle]
//    }
    var body: some View {
        WebView(request: URLRequest(url: URL(string: article.url!)!))
            .navigationBarTitle("Favorite", displayMode: .inline)
            .navigationBarItems(trailing:
                                    FavoriteButton(isSet: $newsViewModel.newsArticles[newsViewModel.indexIdNews.firstIndex(of: article.id) ?? 0].isFavorite)
            
            )
           
    }
}

struct WebView: UIViewRepresentable {
    let request: URLRequest
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(request)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
}

struct NewsDetail_Previews: PreviewProvider {
    static var previews: some View {
        NewsDetail(article: NewsService.shared.json.articles[0])
    }
}
