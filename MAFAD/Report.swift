//
//  Report.swift
//  MainResults
//
//  Created by aisha alh on 20/06/1447 AH.
//


import SwiftUI

// MARK: - Models
struct Report: Identifiable {
    let id: String
    let title: String
    let date: String
    let matchPercentage: Int
}

struct Anomaly: Identifiable {
    let id = UUID()
    let number: Int
    let description: String
}

// MARK: - Main View
struct ContentView: View {
    @State private var reports: [Report] = [
        Report(id: "2847", title: "تجمع عبر مركبتص", date: "10-01-2024", matchPercentage: 92),
        Report(id: "2651", title: "إبلاغ عام", date: "05-01-2024", matchPercentage: 87),
        Report(id: "2490", title: "مخالفة تطاعيم", date: "28-12-2023", matchPercentage: 78),
        Report(id: "2312", title: "تجمع غير مرخص", date: "15-12-2023", matchPercentage: 71)
    ]
    
    @State private var anomalies: [Anomaly] = [
        Anomaly(number: 1, description: "ارتفاع حاد بنسبة 45% في البلاغات خلال الأسبوع الماضي"),
        Anomaly(number: 2, description: "تكرار غير طبيعي لنفس الموقع (5 بلاغات)"),
        Anomaly(number: 3, description: "تزامن مع احداث محلية غير موثقة")
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .trailing, spacing: 24) {
                    // Header
                    HStack {
                        Circle()
                            .fill(Color.green)
                            .frame(width: 50, height: 50)
                            .overlay(
                                Image(systemName: "shield.fill")
                                    .foregroundColor(.white)
                            )
                        
                        Text("قفاد")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.green)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.horizontal)
                    
                    // Report Number
                    Text("بلاغ #0000")
                        .font(.system(size: 36, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.horizontal)
                    
                    // Status Cards
                    HStack(spacing: 16) {
                        StatusCard(
                            icon: "bolt.fill",
                            title: "تصعيد فوري",
                            subtitle: "الإجراء الموصى به",
                            color: .yellow,
                            bgColor: Color.yellow.opacity(0.1)
                        )
                        
                        StatusCard(
                            icon: "shield.fill",
                            title: "78%",
                            subtitle: "درجة المخاطرة",
                            color: .green,
                            bgColor: Color.green.opacity(0.1)
                        )
                        
                        StatusCard(
                            icon: "exclamationmark.triangle.fill",
                            title: "مرتفع",
                            subtitle: "مستوى الخطورة",
                            color: .red,
                            bgColor: Color.red.opacity(0.1)
                        )
                    }
                    .padding(.horizontal)
                    
                    // Similar Reports Section
                    VStack(alignment: .trailing, spacing: 16) {
                        HStack {
                            Image(systemName: "target")
                                .foregroundColor(.green)
                            Text("البلاغات المتشابهة")
                                .font(.system(size: 24, weight: .bold))
                        }
                        .padding(.horizontal)
                        
                        VStack(spacing: 12) {
                            ForEach(reports) { report in
                                ReportCard(report: report)
                            }
                        }
                        .padding()
                        .background(Color.green.opacity(0.05))
                        .cornerRadius(20)
                    }
                    .padding(.horizontal)
                    
                    // Analysis and Anomalies
                    HStack(alignment: .top, spacing: 16) {
                        // Anomalies
                        VStack(alignment: .trailing, spacing: 16) {
                            HStack {
                                Image(systemName: "exclamationmark.triangle.fill")
                                    .foregroundColor(.orange)
                                Text("الشذوذات المكتشفة")
                                    .font(.system(size: 20, weight: .bold))
                            }
                            
                            VStack(spacing: 12) {
                                ForEach(anomalies) { anomaly in
                                    AnomalyCard(anomaly: anomaly)
                                }
                            }
                        }
                        .padding()
                        .background(Color.orange.opacity(0.05))
                        .cornerRadius(20)
                        
                        // Pattern Analysis
                        VStack(alignment: .trailing, spacing: 16) {
                            HStack {
                                Image(systemName: "chart.line.uptrend.xyaxis")
                                    .foregroundColor(.green)
                                Text("تحليل الأنماط")
                                    .font(.system(size: 20, weight: .bold))
                            }
                            
                            VStack(alignment: .trailing, spacing: 16) {
                                PatternItem(
                                    icon: "clock.fill",
                                    title: "نمط زمني",
                                    subtitle: "تكرار في أوقات المساء (8-11 مساءً)",
                                    color: .blue
                                )
                                
                                PatternItem(
                                    icon: "mappin.circle.fill",
                                    title: "نمط جغرافي",
                                    subtitle: "تركز في المنطقة الشمالية",
                                    color: .green
                                )
                                
                                PatternItem(
                                    icon: "person.3.fill",
                                    title: "نمط سلوكي",
                                    subtitle: "ارتباط مع فعاليات رياضية",
                                    color: .purple
                                )
                            }
                        }
                        .padding()
                        .background(Color.gray.opacity(0.05))
                        .cornerRadius(20)
                    }
                    .padding(.horizontal)
                    
                    // Back Button
                    Button(action: {}) {
                        HStack {
                            Image(systemName: "arrow.right")
                            Text("رجوع للوحة التحكم")
                                .font(.system(size: 18, weight: .semibold))
                        }
                        .foregroundColor(.green)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(15)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.green, lineWidth: 2)
                        )
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }
                .padding(.top)
            }
            .background(Color(NSColor.windowBackgroundColor))
        }
        .frame(minWidth: 1200, minHeight: 800)
    }
}

// MARK: - Status Card
struct StatusCard: View {
    let icon: String
    let title: String
    let subtitle: String
    let color: Color
    let bgColor: Color
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 8) {
            HStack {
                Text(title)
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.primary)
                
                Image(systemName: icon)
                    .font(.system(size: 24))
                    .foregroundColor(color)
            }
            
            Text(subtitle)
                .font(.system(size: 14))
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(bgColor)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(color.opacity(0.3), lineWidth: 2)
        )
    }
}

// MARK: - Report Card
struct ReportCard: View {
    let report: Report
    
    var body: some View {
        HStack {
            VStack(alignment: .trailing, spacing: 4) {
                Text("\(report.matchPercentage)%")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.green)
                
                Text("تطابق")
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
            }
            .frame(width: 80)
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text("بلاغ #\(report.id)")
                    .font(.system(size: 16, weight: .semibold))
                
                Text("\(report.title) • \(report.date)")
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
            }
            
            Image(systemName: "doc.text.fill")
                .foregroundColor(.green)
                .font(.system(size: 20))
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

// MARK: - Anomaly Card
struct AnomalyCard: View {
    let anomaly: Anomaly
    
    var body: some View {
        HStack(spacing: 12) {
            Text("\(anomaly.number)")
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.orange)
                .frame(width: 32, height: 32)
                .background(Circle().fill(Color.orange.opacity(0.2)))
            
            Spacer()
            
            Text(anomaly.description)
                .font(.system(size: 14))
                .multilineTextAlignment(.trailing)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
    }
}

// MARK: - Pattern Item
struct PatternItem: View {
    let icon: String
    let title: String
    let subtitle: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(color)
                .font(.system(size: 20))
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text(title)
                    .font(.system(size: 16, weight: .semibold))
                
                Text(subtitle)
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.trailing)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
    }
}

// MARK: - App Entry Point

struct QaffadApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .windowStyle(.hiddenTitleBar)
    }
}
