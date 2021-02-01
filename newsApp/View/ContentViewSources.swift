//
//  ContentViewSources.swift
//  newsApp
//
//  Created by MacBook on 2/1/21.
//

import SwiftUI

struct ContentViewSources: View {
    @EnvironmentObject var newsViewModel : NewsViewModel
    var body: some View {
        NavigationView{
        SourceList()
//            .navigationBarHidden(true)
//                .navigationBarTitle("Sources",displayMode: .inline)
        }
        .environmentObject(newsViewModel)
    }
}

struct ContentViewSources_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewSources()
    }
}
