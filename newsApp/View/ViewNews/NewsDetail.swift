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
    @State var isSet:Bool = false
    var article: Article?
    
    var isNotArticleEmpty: Bool {
        !newsViewModel.newsArticles.isEmpty
    }
    
    
    var body: some View {
        if let articleDetail = article {
            WebView(request: URLRequest(url: URL(string: articleDetail.url!)!))
                .navigationBarTitle("Favorite", displayMode: .inline)
                .navigationBarItems(trailing:
                                        FavoriteButton(isSet: isNotArticleEmpty ? ($newsViewModel.newsArticles[newsViewModel.newsArticles.firstIndex(where: {
                                            $0.url == articleDetail.url
                                        }) ?? 0].isFavorite): .constant(false))
                )
        }
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
