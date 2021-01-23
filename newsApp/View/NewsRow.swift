//
//  NewsRow.swift
//  newsApp
//
//  Created by MacBook on 1/23/21.
//

import SwiftUI

struct NewsRow: View {
//    var newsOne : NewsOne
    var article: Article
    
    var body: some View {
        HStack {
            Image("leo")
                .resizable()
                .frame(width: 100, height: 100)
           
            VStack(alignment:.leading){
                Text(article.title)
                    .font(.title)
//                    .multilineTextAlignment(.leading)
                Text(article.articleDescription)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                Spacer()
                Text(article.publishedAt)
                
            }
            Spacer()
        }
        .frame(height: 100)
    }
}

struct NewsRow_Previews: PreviewProvider {
    static var previews: some View {
        NewsRow(article: NewsService.shared.json.articles[0])
    }
}
