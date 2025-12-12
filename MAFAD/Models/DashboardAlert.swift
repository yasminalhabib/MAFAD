//
//  DashboardAlert.swift
//  MAFAD
//

import Foundation

struct DashboardAlert: Codable, Identifiable {
    let id: String
    let message: String
    let time: String
    let severity: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case message
        case time
        case severity
    }
}
