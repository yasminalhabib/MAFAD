//
//  ReportInputViewModel.swift
//  MAFAD
//

import Foundation
import Combine

@MainActor
class ReportInputViewModel: ObservableObject {
    @Published var reportCode: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var isValidated: Bool = false
    
    func validateAndProceed() async -> Bool {
        guard !reportCode.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "الرجاء إدخال رمز البلاغ"
            return false
        }
        
        isLoading = true
        errorMessage = nil
        
        let formattedCode: String
        if reportCode.uppercased().hasPrefix("ABS-") {
            formattedCode = reportCode.uppercased()
        } else {
            let cleanCode = reportCode.filter { $0.isNumber }
            guard !cleanCode.isEmpty else {
                errorMessage = "رمز البلاغ يجب أن يحتوي على أرقام"
                isLoading = false
                return false
            }
            let paddedCode = String(format: "%06d", Int(cleanCode) ?? 0)
            formattedCode = "ABS-\(paddedCode)"
        }
        
        do {
            let response = try await NetworkService.shared.validateReport(uniqueCode: formattedCode)
            isValidated = response.valid
            isLoading = false
            
            if !response.valid {
                errorMessage = response.message
            }
            return response.valid
        } catch {
            isLoading = false
            errorMessage = error.localizedDescription
            return false
        }
    }
    
    func clearError() {
        errorMessage = nil
    }
}
