// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let aPI = try? newJSONDecoder().decode(API.self, from: jsonData)

import Foundation

// MARK: - API
struct API: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

// MARK: - Article
struct Article: Codable ,Identifiable{
    let id = UUID()
    let source: Source
    let author: String?
    let title, articleDescription: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    var isFavorite: Bool = false


    enum CodingKeys: String, CodingKey {
        case source, author, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt, content
    }
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String
}
