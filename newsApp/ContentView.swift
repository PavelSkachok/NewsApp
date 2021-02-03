//
//  ContentView.swift
//  newsApp
//
//  Created by MacBook on 1/23/21.
//

import SwiftUI
import Combine

class Test: ObservableObject {
    @Published var count: Int = 0
    @Published var present: Int = 0
    var cancellable: AnyCancellable?
    init(){
        cancellable = $count
            .sink(receiveValue:{
                self.present = $0
            })
            
//        print("\(count)")
    }
}



struct ContentView: View {
   
    @ObservedObject var news = NewsViewModel(source: "all")
    @State var tagSource:Int? = 0
//    @ObservedObject var sourceModel = SourceModel()
    var sources = SourceService.shared.jsonSource.sources
    
    var body: some View {
        
        NavigationView {
            VStack {
    //                Text(news.countryEndpoint)
                Picker("",selection: $news.param.index) {
                        Text("topHeadlines").tag(0)
                        Text("everything").tag(1)
                    }.pickerStyle(SegmentedPickerStyle())
                TextField("Search", text: $news.param.keywordOrb)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
        
                if news.param.index == 0 {
                    Text("Category")
                    Picker("", selection: $news.param.category) {
                            Text("business").tag("business")
                            Text("entertainment").tag("entertainment")
                            Text("general").tag("general")
                        }.pickerStyle(SegmentedPickerStyle())
                    Picker("", selection: $news.param.category) {
                            Text("health").tag("health")
                            Text("science").tag("science")
                            Text("sports").tag("sports")
                            Text("technology").tag("technology")
                        }.pickerStyle(SegmentedPickerStyle())
                    Text("Country")
                        Picker("",selection: $news.param.country) {
                        Text("cz").tag("cz")
                        Text("de").tag("de")
                        Text("pl").tag("pl")
                        Text("ru").tag("ru")
                        Text("ua").tag("ua")
                        Text("us").tag("us")
                        Text("fr").tag("fr")
                        Text("gb").tag("gb")
                    }.pickerStyle(SegmentedPickerStyle())
                        ZStack{
                            NavigationLink(destination: ContentViewSources(), tag: 1, selection: $tagSource){
                                EmptyView()
                            }
                            Button(action: {
                                self.tagSource=1
                            }, label: {
                                Text("Sources")
                                    .foregroundColor(.black)
                            })
                            .padding()
                            .background(Color.green)
                            .cornerRadius(8)
                        }
//                        .environmentObject(sourceModel)
                    }
                        
                    NewsList()
                                .navigationTitle("News headlines")
                        .navigationBarHidden(true)
                    
            }
            }
        .environmentObject(news)
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
