//
//  SourceRow.swift
//  newsApp
//
//  Created by MacBook on 2/1/21.
//

import SwiftUI

struct SourceRow: View {
//    @EnvironmentObject var newsViewModel: NewsViewModel
    var source:Source?
   
    var body: some View {
            VStack(alignment:.leading){
                Text(source!.name ?? "")
                    .font(.title)
                    .lineLimit(2)
                Text(source!.description ?? "")
                    .font(.subheadline)
                
            }
            .frame(height: 100)
        }
       
}

struct SourceRow_Previews: PreviewProvider {
    static var previews: some View {
        SourceRow(source: SourceService.shared.jsonSource.sources[0])
    }
}
