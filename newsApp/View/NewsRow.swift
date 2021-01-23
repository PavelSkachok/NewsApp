//
//  NewsRow.swift
//  newsApp
//
//  Created by MacBook on 1/23/21.
//

import SwiftUI
var news = [
    NewsOne(title: "News 1", description: "Description", dateDownload: "Download date", imageName: "leo"),
    NewsOne(title: "News 2", description: "Description", dateDownload: "Download date", imageName: "leo"),
    NewsOne(title: "News 3", description: "Description", dateDownload: "Download date", imageName: "leo"),
    NewsOne(title: "News 4", description: "Description", dateDownload: "Download date", imageName: "leo")
]

struct NewsRow: View {
    var newsOne : NewsOne
    
    var body: some View {
        HStack {
            newsOne.image
                .resizable()
                .frame(width: 100, height: 100)
           
            VStack(alignment:.leading){
                Text(newsOne.title)
                    .font(.title)
                Text(newsOne.description)
                    .font(.subheadline)
                Spacer()
                Text(newsOne.dateDownload)
                
            }
            Spacer()
        }
        .frame(width: .infinity,height: 100)
    }
}

struct NewsRow_Previews: PreviewProvider {
    static var previews: some View {
        NewsRow(newsOne: news[0])
    }
}
