//
//  MafadDashboardView.swift
//  MAFAD
//

import SwiftUI

struct MafadDashboardView: View {
    @State private var animateCards = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .trailing, spacing: 24) {
                    
                    headerSection
                    cardsRow
                    chartsSection
                    bottomSection
                }
                .padding(.horizontal, 20)
                .padding(.top, 24)
                .padding(.bottom, 32)
            }
            .background(
                LinearGradient(
                    colors: [
                        Color("DashboardBackground"),
                        Color("mintcard").opacity(0.18)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
            )
        }
        .environment(\.layoutDirection, .rightToLeft)
        .onAppear {
            animateCards = true
        }
    }
}

// MARK: - Header
private extension MafadDashboardView {
    var headerSection: some View {
        VStack(alignment: .trailing, spacing: 6) {
            Text("لوحة التحكم")
                .font(.system(size: 26, weight: .bold))
                .foregroundColor(.primary)
            
            Text("نظرة عامة على حالة البلاغات ومستوى الأمان")
                .font(.footnote)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
        .opacity(animateCards ? 1 : 0)
        .animation(.easeOut(duration: 0.6), value: animateCards)
    }
}

// MARK: - Top Cards
private extension MafadDashboardView {
    var cardsRow: some View {
        HStack(spacing: 16) {
            StatCardView(
                title: "إجمالي البلاغات",
                value: "1,247",
                changeText: "↑ 12٪ خلال 7 أيام",
                iconName: "doc.text.fill",
                tint: Color("greenmain")
            )
            .opacity(animateCards ? 1 : 0)
            .offset(y: animateCards ? 0 : 20)
            .animation(.spring(response: 0.6).delay(0.1), value: animateCards)
            
            StatCardView(
                title: "حالات عالية الخطورة",
                value: "89",
                changeText: "↓ 8٪ هذا الأسبوع",
                iconName: "exclamationmark.triangle.fill",
                tint: Color("redmain")
            )
            .opacity(animateCards ? 1 : 0)
            .offset(y: animateCards ? 0 : 20)
            .animation(.spring(response: 0.6).delay(0.2), value: animateCards)
            
            StatCardView(
                title: "بلاغات غير مغلقة",
                value: "156",
                changeText: "",
                iconName: "clock.fill",
                tint: Color("yellowmain")
            )
            .opacity(animateCards ? 1 : 0)
            .offset(y: animateCards ? 0 : 20)
            .animation(.spring(response: 0.6).delay(0.3), value: animateCards)
            
            StatCardView(
                title: "متوسط وقت الإغلاق",
                value: "4.2 يوم",
                changeText: "↑ 15٪ عن المعتاد",
                iconName: "chart.line.uptrend.xyaxis",
                tint: Color("greenmain")
            )
            .opacity(animateCards ? 1 : 0)
            .offset(y: animateCards ? 0 : 20)
            .animation(.spring(response: 0.6).delay(0.4), value: animateCards)
        }
        .frame(maxWidth: .infinity)
    }
}

struct StatCardView: View {
    let title: String
    let value: String
    let changeText: String
    let iconName: String
    let tint: Color
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 8) {
            HStack {
                Spacer()
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [tint.opacity(0.20), tint.opacity(0.05)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 32, height: 32)
                    
                    Image(systemName: iconName)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(tint)
                }
            }
            
            Text(title)
                .font(.system(size: 13))
                .foregroundColor(.secondary)
            
            Text(value)
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.primary)
            
            Group {
                if !changeText.isEmpty {
                    Text(changeText)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(tint)
                } else {
                    Text("placeholder")
                        .font(.system(size: 12, weight: .medium))
                        .opacity(0)
                }
            }
            .padding(.vertical, 4)
            .padding(.horizontal, 10)
            .background(
                Capsule()
                    .fill(tint.opacity(0.10))
                    .opacity(changeText.isEmpty ? 0 : 1)
            )
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 18)
        .frame(maxWidth: .infinity)
        .dashboardCardStyle(cornerRadius: 24)
    }
}

// MARK: - Charts
private extension MafadDashboardView {
    var chartsSection: some View {
        HStack(alignment: .top, spacing: 16) {
            trendCard
                .opacity(animateCards ? 1 : 0)
                .animation(.easeOut(duration: 0.6).delay(0.5), value: animateCards)
            
            riskDistributionCard
                .opacity(animateCards ? 1 : 0)
                .animation(.easeOut(duration: 0.6).delay(0.6), value: animateCards)
        }
        .frame(maxWidth: .infinity)
    }
    
    var riskDistributionCard: some View {
        dashboardCard {
            HStack {
                Spacer()
                Image(systemName: "shield.lefthalf.fill")
                    .foregroundColor(Color("greenmain"))
                    .font(.caption)
            }
            
            VStack(alignment: .trailing, spacing: 4) {
                Text("توزيع مستويات الخطورة")
                    .font(.headline)
                Text("نسبة كل مستوى خطورة من إجمالي البلاغات")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.bottom, 4)
            
            ZStack {
                Circle()
                    .trim(from: 0.0, to: 0.45)
                    .stroke(Color("redmain"), lineWidth: 20)
                Circle()
                    .trim(from: 0.45, to: 0.70)
                    .stroke(Color("yellowmain"), lineWidth: 20)
                Circle()
                    .trim(from: 0.70, to: 1.0)
                    .stroke(Color("greenmain"), lineWidth: 20)
            }
            .rotationEffect(.degrees(-90))
            .frame(width: 160, height: 160)
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.vertical, 4)
            
            HStack(spacing: 16) {
                legendDot(color: Color("redmain"), text: "مرتفع")
                legendDot(color: Color("yellowmain"), text: "متوسط")
                legendDot(color: Color("greenmain"), text: "منخفض")
            }
            .font(.footnote)
            .frame(maxWidth: .infinity, alignment: .center)
        }
    }
    
    func legendDot(color: Color, text: String) -> some View {
        HStack(spacing: 4) {
            Circle()
                .fill(color)
                .frame(width: 10, height: 10)
            Text(text)
        }
    }
    
    var trendCard: some View {
        dashboardCard {
            HStack {
                Spacer()
                Image(systemName: "arrow.up.right")
                    .foregroundColor(Color("greenmain"))
                    .font(.caption)
            }
            
            VStack(alignment: .trailing, spacing: 4) {
                Text("اتجاه البلاغات")
                    .font(.headline)
                Text("مقارنة بين البلاغات الواردة والمغلقة")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.bottom, 4)
            
            GeometryReader { geo in
                ZStack {
                    ForEach(0..<4) { i in
                        Rectangle()
                            .fill(Color.gray.opacity(0.12))
                            .frame(height: 1)
                            .offset(y: CGFloat(i) * (geo.size.height / 3))
                    }
                    
                    trendLine(
                        in: geo.size,
                        points: [0.05, 0.25, 0.90, 0.5, 0.65, 0.80]
                    )
                    .stroke(Color("greenmain"), lineWidth: 2)
                    
                    trendLine(
                        in: geo.size,
                        points: [0.0, 0.20, 0.50, 0.48, 0.60, 0.72]
                    )
                    .stroke(Color("greenmain").opacity(0.6), lineWidth: 2)
                }
            }
            .frame(height: 200)
        }
    }
    
    func trendLine(in size: CGSize, points: [CGFloat]) -> Path {
        var path = Path()
        guard !points.isEmpty else { return path }
        
        let stepX = size.width / CGFloat(points.count - 1)
        path.move(to: CGPoint(x: 0, y: size.height * (1 - points[0])))
        
        for (index, value) in points.enumerated() {
            let x = CGFloat(index) * stepX
            let y = size.height * (1 - value)
            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        return path
    }
}

// MARK: - Bottom Section
private extension MafadDashboardView {
    var bottomSection: some View {
        HStack(alignment: .top, spacing: 16) {
            UnclosedReportsCard()
                .opacity(animateCards ? 1 : 0)
                .animation(.easeOut(duration: 0.6).delay(0.7), value: animateCards)
            
            FocusMapCard()
                .opacity(animateCards ? 1 : 0)
                .animation(.easeOut(duration: 0.6).delay(0.8), value: animateCards)
            
            AlertsCard()
                .opacity(animateCards ? 1 : 0)
                .animation(.easeOut(duration: 0.6).delay(0.9), value: animateCards)
        }
        .frame(maxWidth: .infinity)
    }
}

struct UnclosedReportsCard: View {
    let reports: [(days: Int, id: String, area: String)] = [
        (5, "#3042", "الرياض ، حي النرجس"),
        (8, "#3019", "الرياض ، حي الملقا"),
        (12, "#2987", "الرياض ، حي اليرموك"),
        (15, "#2945", "الرياض ، حي الروضة")
    ]
    
    var body: some View {
        dashboardCard {
            HStack {
                Text("بلاغات غير مغلقة")
                    .font(.headline)
                Spacer()
            }
            .padding(.bottom, 4)
            
            HStack(alignment: .top, spacing: 12) {
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(reports, id: \.id) { report in
                        Text("\(report.days) يوم")
                            .foregroundColor(Color("redmain"))
                            .font(.system(size: 14, weight: .medium))
                    }
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(reports, id: \.id) { report in
                        VStack(alignment: .leading, spacing: 2) {
                            Text(report.id)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(.primary)
                            Text(report.area)
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                    }
                }
                Spacer()
            }
        }
    }
}

struct FocusMapCard: View {
    @State private var animateBars = false
    
    let bars: [(value: CGFloat, colorName: String, area: String)] = [
        (45, "redmain", "حي النرجس"),
        (38, "redmain", "حي الملقا"),
        (25, "yellowmain", "حي اليرموك"),
        (18, "yellowmain", "حي الروضة"),
        (12, "greenmain", "حي العليا"),
        (8,  "greenmain", "حي السليمانية")
    ]
    
    var body: some View {
        dashboardCard {
            HStack {
                Text("خريطة التركّز")
                    .font(.headline)
                Spacer()
            }
            .padding(.bottom, 4)
            
            VStack(alignment: .trailing, spacing: 10) {
                ForEach(Array(bars.enumerated()), id: \.element.area) { index, item in
                    HStack {
                        VStack(alignment: .leading, spacing: 2) {
                            Text(item.area)
                                .font(.footnote)
                                .foregroundColor(.primary)
                        }
                        Spacer()
                        ZStack(alignment: .leading) {
                            Capsule()
                                .fill(Color.gray.opacity(0.12))
                                .frame(height: 8)
                            
                            Capsule()
                                .fill(Color(item.colorName))
                                .frame(width: animateBars ? item.value * 3 : 0, height: 8)
                                .animation(
                                    .easeOut(duration: 0.7).delay(0.05 * Double(index)),
                                    value: animateBars
                                )
                        }
                    }
                }
            }
        }
        .onAppear {
            animateBars = true
        }
    }
}

struct AlertsCard: View {
    let alerts = [
        ("ارتفاع ملحوظ في بلاغات التجمعات في شمال الرياض", "قبل 2 ساعة", "yellowmain"),
        ("3 بلاغات متكررة من نفس الموقع خلال 24 ساعة", "قبل 4 ساعات", "redmain"),
        ("انخفاض وقت الإغلاق بنسبة 15% هذا الأسبوع", "قبل 6 ساعات", "greenmain")
    ]
    
    var body: some View {
        dashboardCard {
            HStack {
                Text("التنبيهات")
                    .font(.headline)
                Spacer()
            }
            .padding(.bottom, 4)
            
            VStack(spacing: 10) {
                ForEach(alerts, id: \.0) { item in
                    VStack(alignment: .trailing, spacing: 4) {
                        Text(item.0)
                            .foregroundColor(.primary)
                            .font(.subheadline)
                            .multilineTextAlignment(.trailing)
                        
                        Text(item.1)
                            .font(.caption)
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(10)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(item.2).opacity(0.12))
                    )
                }
            }
        }
    }
}

// MARK: - Helpers
extension View {
    func dashboardCardStyle(cornerRadius: CGFloat = 24) -> some View {
        self
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(
                        LinearGradient(
                            colors: [
                                Color("mintcard"),
                                Color.white.opacity(0.95)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .shadow(color: .black.opacity(0.08), radius: 10, x: 0, y: 5)
            )
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(Color("whitegreen").opacity(0.9), lineWidth: 1)
            )
    }
}

@ViewBuilder
func dashboardCard<Content: View>(@ViewBuilder content: () -> Content) -> some View {
    VStack(alignment: .trailing, spacing: 12) {
        content()
    }
    .padding(18)
    .dashboardCardStyle(cornerRadius: 24)
}

#Preview {
    MafadDashboardView()
        .frame(width: 1200, height: 700)
}
