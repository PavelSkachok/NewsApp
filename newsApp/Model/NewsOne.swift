//
//  NewsOne.swift
//  newsApp
//
//  Created by MacBook on 1/23/21.
//

import Foundation
import SwiftUI

struct NewsOne:Identifiable {
    var id = UUID()
    var title: String
    var description: String
    var dateDownload: String
    var imageName: String
    var image: Image{
        Image(imageName)
    }
}

