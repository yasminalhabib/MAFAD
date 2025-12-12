//
//  Anomaly.swift
//  MAFAD
//

import Foundation

struct Anomaly: Codable, Identifiable {
    let id = UUID()
    let number: Int
    let description: String
    let severity: String
    
    enum CodingKeys: String, CodingKey {
        case number
        case description
        case severity
    }
}
