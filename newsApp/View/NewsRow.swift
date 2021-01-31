//
//  NewsRow.swift
//  newsApp
//
//  Created by MacBook on 1/23/21.
//

import SwiftUI
import URLImage

struct NewsRow: View {
    
//    @ObservedObject var newsViewModel = NewsViewModel()
    @EnvironmentObject var newsViewModel: NewsViewModel
    var indexNews: Int
    var article: Article {
        if !newsViewModel.newsArticles.isEmpty {
            print("Индекс: \(indexNews)")
       return     newsViewModel.newsArticles[indexNews]
            }
        return Article(source: Source(id: "", name: ""), author: "", title: "", articleDescription: "", url: "", urlToImage: "", publishedAt: "", content: "")
    }
   
    
    var body: some View {
        HStack {
            if let stringUrlImage =  article.urlToImage, let url = URL(string:stringUrlImage) {
                URLImage(url: url){ image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipped()
                    .cornerRadius(10)
                    .frame(width: 100, height: 100)
            }
            
        }
                
            VStack(alignment:.leading){
                Text(article.title ?? "")
                    .font(.title)
                    .lineLimit(2)
//                    .multilineTextAlignment(.leading)
                Text(article.articleDescription ?? "")
                    .font(.subheadline)
//                    .multilineTextAlignment(.center)
                Spacer()
                Text(article.publishedAt ?? "")
                
            }
            Spacer()
        }
        .frame(height: 100)
    }
}

struct NewsRow_Previews: PreviewProvider {
    static var previews: some View {
        NewsRow(indexNews: 0)
    }
}
