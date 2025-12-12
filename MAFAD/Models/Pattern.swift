//
//  Pattern.swift
//  MAFAD
//

import Foundation

struct Pattern: Codable, Identifiable {
    let id = UUID()
    let type: String
    let title: String
    let description: String
    let confidence: Double
    let icon: String
    
    enum CodingKeys: String, CodingKey {
        case type
        case title
        case description
        case confidence
        case icon
    }
}
