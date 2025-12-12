//
//  FocusArea.swift
//  MAFAD
//

import SwiftUI
import Combine

struct FocusArea: Codable, Identifiable {
    let id = UUID()
    let name: String
    let reportCount: Int
    let riskLevel: String
    
    var value: CGFloat {
        CGFloat(reportCount)
    }
    
    var colorName: String {
        switch riskLevel.lowercased() {
        case "high", "مرتفع":
            return "redmain"
        case "medium", "متوسط":
            return "yellowmain"
        default:
            return "greenmain"
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case reportCount = "report_count"
        case riskLevel = "risk_level"
    }
}
