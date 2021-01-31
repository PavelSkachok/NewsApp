//
//  NewsList.swift
//  newsApp
//
//  Created by MacBook on 1/23/21.
//

import SwiftUI

struct NewsList: View {
    
    @EnvironmentObject var newsViewModel : NewsViewModel
    @State var showFavoriteOnly = false

    
    
    var filteredArticles:[Article] {
        (newsViewModel.newsArticles.filter{
            article in
            (!showFavoriteOnly || article.isFavorite)
        })
    }
    
    var body: some View {
            NavigationView {
                List{
                    Toggle(isOn: $showFavoriteOnly, label: {
                        Text("Favorites only")
                    })
                    ForEach(filteredArticles) {
                            article in
                        HStack {
                            NavigationLink(destination: NewsDetail(article: article) ){
                                NewsRow(article: article)
                                FavoriteButton(isSet: $newsViewModel.newsArticles[newsViewModel.newsArticles.firstIndex(where: {
                                    $0.url == article.url
                                })!].isFavorite)
                            }
                        }
                    }
                }
                    .navigationTitle("News headlines")
            }
            .environmentObject(newsViewModel)
    }
}

struct NewsList_Previews: PreviewProvider {
    static var previews: some View {
        NewsList()
    }
}
