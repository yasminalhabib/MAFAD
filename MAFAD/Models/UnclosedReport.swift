//
//  UnclosedReport.swift
//  MAFAD
//

import Foundation

struct UnclosedReport: Codable, Identifiable {
    let id = UUID()
    let uniqueCode: String
    let daysOpen: Int
    let area: String
    let category: String
    let dateSent: String

    enum CodingKeys: String, CodingKey {
        case uniqueCode = "unique_code"
        case daysOpen = "days_open"
        case area
        case category
        case dateSent = "date_sent"
    }
}
