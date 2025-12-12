//
//  AnalysisViewModel.swift
//  MAFAD
//

import Foundation
import Combine

@MainActor
class AnalysisViewModel: ObservableObject {
    @Published var currentStep: Int = -1
    @Published var isCompleted: Bool = false
    @Published var analysisResult: AnalysisResult?
    @Published var errorMessage: String?
    
    let reportCode: String
    
    let steps = [
        ("تحليل البلاغ الأساسي", "Incident Analysis"),
        ("استرجاع البلاغات المشابهة", "Similar Case Retrieval (RAG)"),
        ("اكتشاف الأنماط", "Pattern Detection"),
        ("رصد البلاغات غير المغلقة", "Unresolved Case Tracking"),
        ("التوصيات الأمنية", "AI Security Recommendation"),
        ("توقع مستوى الخطورة", "Risk Prediction"),
        ("بناء خلاصة التحليل", "Final Insights")
    ]
    
    init(reportCode: String) {
        self.reportCode = reportCode
    }
    
    func startAnalysis() async {
        for i in 0..<steps.count {
            currentStep = i
            
            if i == steps.count - 1 {
                await performAnalysis()
            } else {
                try? await Task.sleep(nanoseconds: 700_000_000)
            }
        }
    }
    
    private func performAnalysis() async {
        do {
            let result = try await NetworkService.shared.analyzeReport(uniqueCode: reportCode)
            self.analysisResult = result
            self.isCompleted = true
        } catch {
            self.errorMessage = error.localizedDescription
            self.isCompleted = false
        }
    }
}
