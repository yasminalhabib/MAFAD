import SwiftUI

struct MafadDashboardView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .trailing, spacing: 24) {
                    
                    // 🔹 العنوان الرئيسي للداشبورد
                    headerSection
                    
                    // 🔹 بطاقات الإحصائيات العلوية
                    cardsRow
                    
                    // 🔹 قسم الرسوم (اتجاه البلاغات + توزيع المخاطر)
                    chartsSection
                    
                    // 🔹 البطاقات السفلية (التنبيهات + خريطة التركّز + البلاغات غير المغلقة)
                    bottomSection
                }
                .padding(.horizontal, 20)
                .padding(.top, 24)
                .padding(.bottom, 40)
            }
            .background(
                Color("DashboardBackground")
                    .ignoresSafeArea()
            )
        }
        // 🔹 جعل الواجهة بالكامل من اليمين لليسار
        .environment(\.layoutDirection, .rightToLeft)
    }
}

// MARK: - Header

private extension MafadDashboardView {
    var headerSection: some View {
        VStack(alignment: .trailing, spacing: 4) {
            HStack {
                Spacer()
                Text("لوحة التحكم")
                    .font(.footnote)
                    .foregroundColor(.secondary)
                
                Image(systemName: "slider.horizontal.3")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            
            Text("نظرة عامة على الأمان")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.primary)
        }
    }
}

// MARK: - Top Stat Cards

private extension MafadDashboardView {
    var cardsRow: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                StatCardView(
                    title: "إجمالي البلاغات",
                    value: "1,247",
                    changeText: "12٪ ↑",
                    iconName: "doc.text.fill",
                    tint: Color("greenmain")
                )
                
                StatCardView(
                    title: "حالات عالية الخطورة",
                    value: "89",
                    changeText: "8٪ ↓",
                    iconName: "exclamationmark.triangle.fill",
                    tint: Color("redmain")
                )
                
                StatCardView(
                    title: "بلاغات غير مغلقة",
                    value: "156",
                    changeText: "",
                    iconName: "clock.fill",
                    tint: Color("yellowmain")
                )
                
                StatCardView(
                    title: "متوسط وقت الإغلاق",
                    value: "4.2 يوم",
                    changeText: "15٪ ↑",
                    iconName: "chart.line.uptrend.xyaxis",
                    tint: Color("greenmain")
                )
            }
            .padding(.vertical, 4)
        }
    }
}

// 🔹 كرت إحصائي واحد يُستخدم في الشريط العلوي
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
                        .fill(tint.opacity(0.15))
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
            
            if !changeText.isEmpty {
                Text(changeText)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(tint)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 18)
        .frame(width: 190)
        .dashboardCardStyle(cornerRadius: 24)
    }
}

// MARK: - Charts (Donut + Trend)

private extension MafadDashboardView {
    var chartsSection: some View {
        HStack(alignment: .top, spacing: 16) {
            // ✅ أولاً: اتجاه البلاغات
            trendCard
            // ✅ ثم: توزيع المخاطر
            riskDistributionCard
        }
    }
    
    var riskDistributionCard: some View {
        dashboardCard {
            HStack {
                Spacer()
                Image(systemName: "triangle.fill")
                    .foregroundColor(Color("greenmain"))
                    .font(.caption)
            }
            
            Text("توزيع المخاطر")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            // 🔹 رسم الدونات المكوّن من ثلاث شرائح (مرتفع - متوسط - منخفض)
            ZStack {
                Circle()
                    .trim(from: 0.0, to: 0.45)
                    .stroke(Color("redmain"), lineWidth: 20)
                Circle()
                    .trim(from: 0.45, to: 0.70)
                    .stroke(Color("greenmain"), lineWidth: 20)
                Circle()
                    .trim(from: 0.70, to: 1.0)
                    .stroke(Color("yellowmain"), lineWidth: 20)
            }
            .rotationEffect(.degrees(-90))
            .frame(width: 140, height: 140)
            .frame(maxWidth: .infinity, alignment: .center)
            
            HStack(spacing: 16) {
                legendDot(color: Color("redmain"), text: "مرتفع")
                legendDot(color: Color("yellowmain"), text: "متوسط")
                legendDot(color: Color("greenmain"), text: "منخفض")
            }
            .font(.footnote)
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .frame(maxWidth: .infinity)
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
            
            Text("اتجاه البلاغات")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            // 🔹 رسم خطين يوضّحان اتجاه البلاغات مع شبكة بسيطة
            GeometryReader { geo in
                ZStack {
                    ForEach(0..<4) { i in
                        Rectangle()
                            .fill(Color.gray.opacity(0.15))
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
            .frame(height: 180)
        }
        .frame(maxWidth: .infinity)
    }
    
    // 🔹 دالة مسؤولة عن رسم مسار من نقاط (0...1) تمثّل ارتفاع الخط
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

// MARK: - Bottom Section (Reports + Focus Map + Alerts)

private extension MafadDashboardView {
    var bottomSection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 16) {
                AlertsCard()
                FocusMapCard()
                UnclosedReportsCard()
            }
            .padding(.top, 8)
        }
    }
}

// MARK: - Shared Card Base + Style

// 🔹 ستايل موحّد للكروت (خلفية + ظل + بوردر)
extension View {
    func dashboardCardStyle(cornerRadius: CGFloat = 24) -> some View {
        self
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color("mintcard"))
                    .shadow(color: .black.opacity(0.10), radius: 10, x: 0, y: 4)
            )
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(Color("whitegreen"), lineWidth: 1)
            )
    }
}

// 🔹 كرت عام يُستخدم لبقية الأقسام (تنبيهات، خريطة، بلاغات...)
@ViewBuilder
func dashboardCard<Content: View>(@ViewBuilder content: () -> Content) -> some View {
    VStack(alignment: .trailing, spacing: 16) {
        content()
    }
    .padding(20)
    .dashboardCardStyle(cornerRadius: 24)
}

// MARK: - Unclosed Reports Card

struct UnclosedReportsCard: View {
    
    // 🔹 بيانات تجريبية للبلاغات غير المغلقة
    let reports: [(days: Int, id: String, area: String)] = [
        (5, "#3042", "الرياض ، حي النرجس"),
        (8, "#3019", "الرياض ، حي الملقا"),
        (12, "#2987", "الرياض ، حي اليرموك"),
        (15, "#2945", "الرياض ، حي الروضة")
    ]
    
    var body: some View {
        dashboardCard {
            HStack {
                Image(systemName: "clock")
                    .foregroundColor(Color("yellowmain"))
                Text("بلاغات غير مغلقة")
                    .font(.headline)
                Spacer()
            }
            
            VStack(alignment: .trailing, spacing: 16) {
                ForEach(reports, id: \.id) { report in
                    HStack {
                        VStack(alignment: .leading, spacing: 2) {
                            Text(report.id)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(.primary)
                            Text(report.area)
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Text("\(report.days) يوم")
                            .foregroundColor(Color("redmain"))
                            .font(.system(size: 14, weight: .medium))
                    }
                }
            }
        }
        .frame(width: 300)
    }
}

// MARK: - Focus Map Card

struct FocusMapCard: View {
    
    // 🔹 بيانات تجريبية لتمثيل تركّز البلاغات في الأحياء
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
                Image(systemName: "mappin.and.ellipse")
                    .foregroundColor(Color("greenmain"))
                Text("خريطة التركّز")
                    .font(.headline)
                Spacer()
            }
            
            VStack(alignment: .trailing, spacing: 14) {
                ForEach(bars, id: \.area) { item in
                    HStack {
                        ZStack(alignment: .leading) {
                            Capsule()
                                .fill(Color.gray.opacity(0.15))
                                .frame(height: 8)
                            
                            Capsule()
                                .fill(Color(item.colorName))
                                .frame(width: item.value * 3, height: 8)
                        }
                        
                        Text(item.area)
                            .font(.footnote)
                            .foregroundColor(.primary)
                            .frame(width: 110, alignment: .trailing)
                    }
                }
            }
        }
        .frame(width: 300)
    }
}

// MARK: - Alerts Card

struct AlertsCard: View {
    
    // 🔹 قائمة التنبيهات (نص + وقت + لون)
    let alerts = [
        ("ارتفاع ملحوظ في بلاغات التجمعات في شمال الرياض", "قبل 2 ساعة", "yellowmain"),
        ("3 بلاغات متكررة من نفس الموقع خلال 24 ساعة", "قبل 4 ساعات", "redmain"),
        ("انخفاض وقت الإغلاق بنسبة 15% هذا الأسبوع", "قبل 6 ساعات", "greenmain")
    ]
    
    var body: some View {
        dashboardCard {
            HStack {
                Image(systemName: "bell")
                    .foregroundColor(Color("greenmain"))
                Text("التنبيهات")
                    .font(.headline)
                Spacer()
            }
            
            VStack(spacing: 12) {
                ForEach(alerts, id: \.0) { item in
                    VStack(alignment: .trailing, spacing: 4) {
                        Text(item.0)
                            .foregroundColor(.primary)
                            .font(.subheadline)
                            .multilineTextAlignment(.trailing)
                        
                        Text(item.1)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(item.2).opacity(0.15))
                    )
                }
            }
        }
        .frame(width: 300)
    }
}

// MARK: - Preview

struct MafadDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        MafadDashboardView()
    }
}
