//
//  SimilarReport.swift
//  MAFAD
//

import Foundation

struct SimilarReport: Codable, Identifiable {
    let id = UUID()
    let reportId: String
    let category: String
    let date: String
    let matchPercentage: Int
    let area: String

    enum CodingKeys: String, CodingKey {
        case reportId = "report_id"
        case category
        case date
        case matchPercentage = "match_percentage"
        case area
    }
}
