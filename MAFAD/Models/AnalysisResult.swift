//
//  AnalysisResult.swift
//  MAFAD
//

import Foundation

struct AnalysisResult: Codable {
    let reportId: String
    let riskScore: Double
    let riskLevel: String
    let recommendedAction: String
    let similarReports: [SimilarReport]
    let anomalies: [Anomaly]
    let patterns: [Pattern]
    let analysisDate: String

    enum CodingKeys: String, CodingKey {
        case reportId = "report_id"
        case riskScore = "risk_score"
        case riskLevel = "risk_level"
        case recommendedAction = "recommended_action"
        case similarReports = "similar_reports"
        case anomalies
        case patterns
        case analysisDate = "analysis_date"
    }
}
