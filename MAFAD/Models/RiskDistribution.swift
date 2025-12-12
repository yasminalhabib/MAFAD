//
//  RiskDistribution.swift
//  MAFAD
//

import Foundation

struct RiskDistribution: Codable {
    let high: Int
    let medium: Int
    let low: Int
    let highPercentage: Double
    let mediumPercentage: Double
    let lowPercentage: Double

    enum CodingKeys: String, CodingKey {
        case high
        case medium
        case low
        case highPercentage = "high_percentage"
        case mediumPercentage = "medium_percentage"
        case lowPercentage = "low_percentage"
    }
}
