//
//  SourceList.swift
//  newsApp
//
//  Created by MacBook on 2/1/21.
//

import SwiftUI

struct SourceList: View {
//    @ObservedObject var newsViewModel = NewsViewModel()
    var sources:[Source]
    var body: some View {
        List{
            ForEach(sources, id: \.id) {
                    source in
                HStack {
                    NavigationLink(destination: SourceDetail(newsViewModel: NewsViewModel(source: source.name!), source:source)
                    ){
                        SourceRow(source: source)
                    }
                }
            }
        }
        .listStyle(PlainListStyle())
//    .environmentObject(newsViewModel)
    }
}

struct SourceList_Previews: PreviewProvider {
    static var previews: some View {
        SourceList(sources: SourceService.shared.jsonSource.sources)
    }
}
