//
//  ReportResultsViewModel.swift
//  MAFAD
//

import Foundation
import Combine

@MainActor
class ReportResultsViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var analysisResult: AnalysisResult?
    @Published var errorMessage: String?
    
    func loadAnalysisResult(reportId: String) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let result = try await NetworkService.shared.analyzeReport(uniqueCode: reportId)
            self.analysisResult = result
            self.isLoading = false
        } catch {
            self.errorMessage = error.localizedDescription
            self.isLoading = false
        }
    }
}
