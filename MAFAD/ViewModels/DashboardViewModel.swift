//
//  DashboardViewModel.swift
//  MAFAD
//

import Foundation
import Combine

@MainActor
class DashboardViewModel: ObservableObject {
    @Published var stats: DashboardStats?
    @Published var unclosedReports: [UnclosedReport] = []
    @Published var riskDistribution: RiskDistribution?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    func loadDashboardData() async {
        isLoading = true
        errorMessage = nil
        
        async let statsTask = NetworkService.shared.getDashboardStats()
        async let unclosedTask = NetworkService.shared.getUnclosedReports()
        async let riskTask = NetworkService.shared.getRiskDistribution()
        
        do {
            let (stats, unclosed, risk) = try await (statsTask, unclosedTask, riskTask)
            self.stats = stats
            self.unclosedReports = unclosed
            self.riskDistribution = risk
            self.isLoading = false
        } catch {
            self.errorMessage = error.localizedDescription
            self.isLoading = false
        }
    }
    
    func refresh() async {
        await loadDashboardData()
    }
}
