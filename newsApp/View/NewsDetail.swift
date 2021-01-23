//
//  NewsDetail.swift
//  newsApp
//
//  Created by MacBook on 1/23/21.
//

import SwiftUI

struct NewsDetail: View {
    var newsOne:NewsOne
    var body: some View {
        ScrollView {
            VStack {
                Text(newsOne.title)
                    .font(.title)
                Divider()
                Text(newsOne.description)
            }
            
        }
        .navigationTitle(newsOne.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct NewsDetail_Previews: PreviewProvider {
    static var previews: some View {
        NewsDetail(newsOne: news[0])
    }
}
