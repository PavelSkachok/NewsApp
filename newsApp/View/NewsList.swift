//
//  NewsList.swift
//  newsApp
//
//  Created by MacBook on 1/23/21.
//

import SwiftUI

struct NewsList: View {
    var body: some View {
        NavigationView {
            List(news){newsElement in
                NavigationLink(destination: NewsDetail(newsOne: newsElement)) {
                    NewsRow(newsOne: newsElement)
                }
            }
            .navigationTitle("News")
        }
    }
}

struct NewsList_Previews: PreviewProvider {
    static var previews: some View {
        NewsList()
    }
}
