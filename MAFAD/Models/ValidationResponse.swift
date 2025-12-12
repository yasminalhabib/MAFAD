//
//  ValidationResponse.swift
//  MAFAD
//

import Foundation

struct ValidationResponse: Codable {
    let valid: Bool
    let reportId: String
    let message: String

    enum CodingKeys: String, CodingKey {
        case valid
        case reportId = "report_id"
        case message
    }
}
