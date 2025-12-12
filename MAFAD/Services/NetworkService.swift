//
//  NetworkService.swift
//  MAFAD
//
//  Created by Hneen on 21/06/1447 AH.
//
import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case invalidResponse
    case decodingError(Error)
    case serverError(Int, String?)
    case noData
    case requestFailed(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "عنوان URL غير صحيح"
        case .invalidResponse:
            return "استجابة غير صالحة من الخادم"
        case .decodingError(let error):
            return "خطأ في معالجة البيانات: \(error.localizedDescription)"
        case .serverError(let code, let message):
            if let message = message {
                return "خطأ في الخادم (\(code)): \(message)"
            }
            return "خطأ في الخادم: \(code)"
        case .noData:
            return "لا توجد بيانات"
        case .requestFailed(let error):
            return "فشل الاتصال: \(error.localizedDescription)"
        }
    }
}

class NetworkService {
    static let shared = NetworkService()
    private let baseURL = "https://10.0.13.238:8000"
    private let session: URLSession
    
    private init() {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30   // 3 دقائق
        config.timeoutIntervalForResource = 60  // 5 دقائق

        self.session = URLSession(configuration: config)
    }

    
    private func makeRequest(endpoint: String, method: String = "GET") async throws -> Data {
        guard let url = URL(string: "\(baseURL)\(endpoint)") else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                let errorMessage = String(data: data, encoding: .utf8)
                throw NetworkError.serverError(httpResponse.statusCode, errorMessage)
            }
            
            return data
        } catch let error as NetworkError {
            throw error
        } catch {
            throw NetworkError.requestFailed(error)
        }
    }
    
    func validateReport(uniqueCode: String) async throws -> ValidationResponse {
        let cleanCode = uniqueCode.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? uniqueCode
        let endpoint = "/api/reports/validate?unique_code=\(cleanCode)"
        let data = try await makeRequest(endpoint: endpoint, method: "POST")
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(ValidationResponse.self, from: data)
        } catch {
            throw NetworkError.decodingError(error)
        }
    }
    
    func analyzeReport(uniqueCode: String) async throws -> AnalysisResult {
        let cleanCode = uniqueCode.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? uniqueCode
        let endpoint = "/api/reports/analyze?unique_code=\(cleanCode)"
        let data = try await makeRequest(endpoint: endpoint, method: "POST")
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(AnalysisResult.self, from: data)
        } catch {
            print("Decoding error: \(error)")
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Response: \(jsonString)")
            }
            throw NetworkError.decodingError(error)
        }
    }
    
    func getDashboardStats() async throws -> DashboardStats {
        let endpoint = "/api/dashboard/stats"
        let data = try await makeRequest(endpoint: endpoint)
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(DashboardStats.self, from: data)
        } catch {
            throw NetworkError.decodingError(error)
        }
    }
    
    func getUnclosedReports() async throws -> [UnclosedReport] {
        let endpoint = "/api/dashboard/unclosed"
        let data = try await makeRequest(endpoint: endpoint)
        
        do {
            let decoder = JSONDecoder()
            let response = try decoder.decode([String: [UnclosedReport]].self, from: data)
            return response["unclosed_reports"] ?? []
        } catch {
            throw NetworkError.decodingError(error)
        }
    }
    
    func getRiskDistribution() async throws -> RiskDistribution {
        let endpoint = "/api/dashboard/risk-distribution"
        let data = try await makeRequest(endpoint: endpoint)
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(RiskDistribution.self, from: data)
        } catch {
            throw NetworkError.decodingError(error)
        }
    }
    
    func healthCheck() async throws -> Bool {
        let endpoint = "/health"
        do {
            let data = try await makeRequest(endpoint: endpoint)
            let response = try JSONDecoder().decode([String: String].self, from: data)
            return response["status"] == "healthy"
        } catch {
            return false
        }
    }
}
