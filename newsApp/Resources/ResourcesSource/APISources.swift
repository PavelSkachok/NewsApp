// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let aPISources = try APISources(json)

import Foundation

// MARK: - APISources
struct APISources:Codable {
    let status: String?
    let sources: [Source]
}

// MARK: - Source
struct Source:Codable,Identifiable {
    let id, name, description: String?
    let url: String?
    let category, language, country: String?
}
