//
//  NewsDetail.swift
//  newsApp
//
//  Created by MacBook on 1/23/21.
//

import SwiftUI
import WebKit



struct SourceDetail: View {

    @ObservedObject var newsViewModel: NewsViewModel

    var source: Source?
    
    
    var body: some View {
        
        
        
        NavigationLink(
            destination: WebViewSource(request: URLRequest(url: URL(string: (source?.url)!)!))
                .navigationBarTitle((source?.name)!, displayMode: .inline),
            label: {
                Text((source?.url)!)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.black)
                    .cornerRadius(8)
            })
        NewsList()
            .environmentObject(newsViewModel)
            .navigationBarTitle((source?.name)!, displayMode: .inline)
        
    }
}

struct WebViewSource: UIViewRepresentable {
    let request: URLRequest
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(request)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
}

struct SourceDetail_Previews: PreviewProvider {
    static var previews: some View {
        SourceDetail(newsViewModel: NewsViewModel(source: "all"), source: SourceService.shared.jsonSource.sources[0])
    }
}
