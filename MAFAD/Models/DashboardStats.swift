//
//  DashboardStats.swift
//  MAFAD
//

import Foundation

struct DashboardStats: Codable {
    let totalReports: Int
    let highRiskCases: Int
    let unclosedReports: Int
    let averageClosingTime: Double
    let recentAlerts: [DashboardAlert]
    let focusAreas: [FocusArea]

    enum CodingKeys: String, CodingKey {
        case totalReports = "total_reports"
        case highRiskCases = "high_risk_cases"
        case unclosedReports = "unclosed_reports"
        case averageClosingTime = "average_closing_time"
        case recentAlerts = "recent_alerts"
        case focusAreas = "focus_areas"
    }
}
