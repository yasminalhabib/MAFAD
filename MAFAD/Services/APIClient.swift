////
////  APIClient.swift
////  MAFAD
////
////  Created by Hneen on 21/06/1447 AH.
////
//import Foundation
//
//struct APIConfig {
//    static let baseURL = "http://10.0.13.238:8000"
//    static let timeout: TimeInterval = 30
//    
//    enum Endpoint {
//        case health
//        case validate(uniqueCode: String)
//        case analyze(uniqueCode: String)
//        case dashboardStats
//        case unclosedReports
//        case riskDistribution
//        case reportsCount
//        
//        var path: String {
//            switch self {
//            case .health:
//                return "/health"
//            case .validate(let code):
//                let encoded = code.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? code
//                return "/api/reports/validate?unique_code=\(encoded)"
//            case .analyze(let code):
//                let encoded = code.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? code
//                return "/api/reports/analyze?unique_code=\(encoded)"
//            case .dashboardStats:
//                return "/api/dashboard/stats"
//            case .unclosedReports:
//                return "/api/dashboard/unclosed"
//            case .riskDistribution:
//                return "/api/dashboard/risk-distribution"
//            case .reportsCount:
//                return "/api/reports/count"
//            }
//        }
//        
//        var method: String {
//            switch self {
//            case .validate, .analyze:
//                return "POST"
//            default:
//                return "GET"
//            }
//        }
//    }
//}
//
//class APIClient {
//    static let shared = APIClient()
//    
//    private let session: URLSession
//    
//    private init() {
//        let config = URLSessionConfiguration.default
//        config.timeoutIntervalForRequest = APIConfig.timeout
//        config.timeoutIntervalForResource = APIConfig.timeout * 2
//        config.waitsForConnectivity = true
//        self.session = URLSession(configuration: config)
//    }
//    
//    func request<T: Decodable>(_ endpoint: APIConfig.Endpoint, responseType: T.Type) async throws -> T {
//        guard let url = URL(string: APIConfig.baseURL + endpoint.path) else {
//            throw NetworkError.invalidURL
//        }
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = endpoint.method
//        request.setValue("application/json", forHTTPHeaderField: "Accept")
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        
//        do {
//            let (data, response) = try await session.data(for: request)
//            
//            guard let httpResponse = response as? HTTPURLResponse else {
//                throw NetworkError.invalidResponse
//            }
//            
//            guard (200...299).contains(httpResponse.statusCode) else {
//                if let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
//                    throw NetworkError.serverError(httpResponse.statusCode, errorResponse.detail)
//                }
//                throw NetworkError.serverError(httpResponse.statusCode, nil)
//            }
//            
//            let decoder = JSONDecoder()
//            decoder.dateDecodingStrategy = .iso8601
//            
//            do {
//                let result = try decoder.decode(T.self, from: data)
//                return result
//            } catch {
//                print("Decoding error: \(error)")
//                if let jsonString = String(data: data, encoding: .utf8) {
//                    print("Response data: \(jsonString)")
//                }
//                throw NetworkError.decodingError(error)
//            }
//            
//        } catch let error as NetworkError {
//            throw error
//        } catch {
//            throw NetworkError.requestFailed(error)
//        }
//    }
//    
//    func healthCheck() async -> Bool {
//        do {
//            let response: HealthCheckResponse = try await request(.health, responseType: HealthCheckResponse.self)
//            return response.status == "healthy"
//        } catch {
//            print("Health check failed: \(error.localizedDescription)")
//            return false
//        }
//    }
//}
//
//extension APIClient {
//    func validateReport(uniqueCode: String) async throws -> ValidationResponse {
//        return try await request(.validate(uniqueCode: uniqueCode), responseType: ValidationResponse.self)
//    }
//    
//    func analyzeReport(uniqueCode: String) async throws -> AnalysisResult {
//        return try await request(.analyze(uniqueCode: uniqueCode), responseType: AnalysisResult.self)
//    }
//    
//    func getDashboardStats() async throws -> DashboardStats {
//        return try await request(.dashboardStats, responseType: DashboardStats.self)
//    }
//    
//    func getUnclosedReports() async throws -> [UnclosedReport] {
//        struct Response: Codable {
//            let unclosedReports: [UnclosedReport]
//            
//            enum CodingKeys: String, CodingKey {
//                case unclosedReports = "unclosed_reports"
//            }
//        }
//        let response = try await request(.unclosedReports, responseType: Response.self)
//        return response.unclosedReports
//    }
//    
//    func getRiskDistribution() async throws -> RiskDistribution {
//        return try await request(.riskDistribution, responseType: RiskDistribution.self)
//    }
//}
