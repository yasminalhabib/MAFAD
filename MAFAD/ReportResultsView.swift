//
//  ReportResultsView.swift
//  MainResults
//
//  Created by aisha alh on 20/06/1447 AH.
//


import SwiftUI

struct ReportResultsView: View {
    @State private var animate = false
    @State private var showCards = false
    @State private var scrollOffset: CGFloat = 0
    @State private var isReturnHovered = false
    @State private var isReturnPressed = false
    @State private var isHomeHovered = false
    @State private var isReportsHovered = false
    @State private var isDashboardHovered = false

    var body: some View {
        ScrollView {
            VStack(spacing: 32) {

                // ---------------- TOP BAR ----------------
                HStack {
                    HStack(spacing: 12) {
                        ZStack {
                            Circle()
                                .fill(Color(red: 0.12, green: 0.55, blue: 0.32))
                                .frame(width: 48, height: 48)

                            Image(systemName: "shield")
                                .foregroundColor(.white)
                                .font(.system(size: 22))
                        }

                        Text("مَفاد")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(Color(red: 0.12, green: 0.55, blue: 0.32))
                    }

                    Spacer(minLength: 0)

                    HStack(spacing: 16) {
                        Text("الرئيسية")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(Color.gray)
                        Image(systemName: "house")
                            .font(.system(size: 18))
                            .foregroundColor(Color.gray)
                    }
                    .scaleEffect(isHomeHovered ? 1.08 : 1.0)
                    .animation(.easeOut(duration: 0.2), value: isHomeHovered)
                    .onHover { hovering in
                        isHomeHovered = hovering
                    }

                    HStack(spacing: 16) {
                        Text("البلاغات")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(Color.gray)
                        Image(systemName: "doc.text")
                            .font(.system(size: 18))
                            .foregroundColor(Color.gray)
                    }
                    .scaleEffect(isReportsHovered ? 1.08 : 1.0)
                    .animation(.easeOut(duration: 0.2), value: isReportsHovered)
                    .onHover { hovering in
                        isReportsHovered = hovering
                    }

                    HStack(spacing: 16) {
                        Text("لوحة التحكم")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(Color.gray)
                        Image(systemName: "chart.bar")
                            .font(.system(size: 18))
                            .foregroundColor(Color.gray)
                    }
                    .scaleEffect(isDashboardHovered ? 1.08 : 1.0)
                    .animation(.easeOut(duration: 0.2), value: isDashboardHovered)
                    .onHover { hovering in
                        isDashboardHovered = hovering
                    }
                }
                .padding(.horizontal)
                .padding(.top, 10)
                .padding(.bottom, 6)
                .background(Color.white)

                // ------------ HEADER ------------
                HStack(alignment: .top) {
                    VStack(alignment: .trailing, spacing: 4) {
                        Text("نتائج التحليل")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.black)

                        Text("بلاغ #0000")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.black)
                    }

                    Spacer()

                    Image(systemName: "doc.text")
                        .font(.system(size: 24))
                        .foregroundColor(.black)
                }
                .padding(.horizontal)
                .offset(y: -scrollOffset * 0.15)
                .opacity(1 - min(max(scrollOffset / 150, 0), 0.4))
                .animation(.easeOut, value: scrollOffset)

                // ---------------- TOP CARDS ----------------
                HStack(spacing: 16) {

                    // الإجراء الموصى به
                    TopCard(
                        title: "الإجراء الموصى به",
                        value: "تصعيد فوري",
                        icon: "bolt.fill",
                        bg: Color(red: 1, green: 1, blue: 0.95),
                        border: Color(red: 1, green: 0.93, blue: 0.65),
                        textColor: .black
                    )
                    .opacity(showCards ? 1 : 0)
                    .offset(y: showCards ? 0 : 20)
                    .animation(.easeOut(duration: 0.5).delay(0.1), value: showCards)

                    // درجة المخاطرة
                    TopCard(
                        title: "درجة المخاطرة",
                        value: "78%",
                        icon: "shield.fill",
                        bg: Color(red: 0.95, green: 1, blue: 0.95),
                        border: Color(red: 0.85, green: 1, blue: 0.85),
                        textColor: Color(red: 0, green: 0.5, blue: 0)
                    )
                    .opacity(showCards ? 1 : 0)
                    .offset(y: showCards ? 0 : 20)
                    .animation(.easeOut(duration: 0.5).delay(0.2), value: showCards)

                    // مستوى الخطورة
                    TopCard(
                        title: "مستوى الخطورة",
                        value: "مرتفع",
                        icon: "exclamationmark.triangle.fill",
                        bg: Color(red: 1, green: 0.95, blue: 0.95),
                        border: Color(red: 1, green: 0.80, blue: 0.80),
                        textColor: .red
                    )
                    .opacity(showCards ? 1 : 0)
                    .offset(y: showCards ? 0 : 20)
                    .animation(.easeOut(duration: 0.5).delay(0.3), value: showCards)
                }
                .padding(.horizontal)

                // --------------- البلاغات المشابهة ---------------
                VStack(alignment: .trailing, spacing: 20) {

                    HStack {
                        Text("البلاغات المشابهة")
                            .font(.system(size: 20, weight: .bold))
                        Spacer()
                        Image(systemName: "scope")
                            .font(.system(size: 20))
                            .foregroundColor(Color.green)
                    }

                    VStack(spacing: 40) {
                        SimilarReportRow(percent: "92%", title: "بلاغ #2847", subtitle: "تجمع غير مرخص • 10-01-2024")
                            .opacity(animate ? 1 : 0)
                            .offset(x: animate ? 0 : 40)
                            .animation(.easeOut(duration: 0.5).delay(0.4), value: animate)
                        SimilarReportRow(percent: "87%", title: "بلاغ #2651", subtitle: "إزعاج عام • 05-01-2024")
                            .opacity(animate ? 1 : 0)
                            .offset(x: animate ? 0 : 40)
                            .animation(.easeOut(duration: 0.5).delay(0.5), value: animate)
                        SimilarReportRow(percent: "78%", title: "بلاغ #2490", subtitle: "مخالفة نظامية • 28-12-2023")
                            .opacity(animate ? 1 : 0)
                            .offset(x: animate ? 0 : 40)
                            .animation(.easeOut(duration: 0.5).delay(0.6), value: animate)
                        SimilarReportRow(percent: "71%", title: "بلاغ #2312", subtitle: "تجمع غير مرخص • 15-12-2023")
                            .opacity(animate ? 1 : 0)
                            .offset(x: animate ? 0 : 40)
                            .animation(.easeOut(duration: 0.5).delay(0.7), value: animate)
                    }
                    .padding()
                    .opacity(animate ? 1 : 0)
                    .offset(x: animate ? 0 : 40)
                    .animation(.easeOut(duration: 0.6).delay(0.15), value: animate)
                    .background(Color(red: 0.96, green: 1, blue: 0.97))
                    .cornerRadius(26)

                }
                
                .animation(.easeOut, value: scrollOffset)
                .padding(.horizontal)

                // --------------- الشذوذات + تحليل الأنماط (Fixed Layout) ---------------
                VStack(spacing: 24) {
                    anomaliesCard
                    patternsCard
                }
                .padding(.horizontal)

                // --------------- زر العودة ---------------
                NavigationLink(destination: DashboardView()) {
                    HStack {
                        Text("رجوع للوحة التحكم")
                            .font(.system(size: 22, weight: .semibold))
                        Image(systemName: "arrow.right")
                            .font(.system(size: 20, weight: .medium))
                    }
                    .foregroundColor(Color(red: 0.12, green: 0.55, blue: 0.32))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 22)
                    .scaleEffect(isReturnPressed ? 0.95 : 1.0)
                    .scaleEffect(isReturnHovered ? 1.03 : 1.0)
                    .animation(.easeOut(duration: 0.2), value: isReturnHovered)
                    .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isReturnPressed)
                    .overlay(
                        RoundedRectangle(cornerRadius: 60)
                            .stroke(Color(red: 0.12, green: 0.55, blue: 0.32), lineWidth: 3)
                    )
                }
                .padding(.horizontal)
                .padding(.vertical, 20)
                .onHover { hovering in
                    isReturnHovered = hovering
                }
            }
            .opacity(animate ? 1 : 0)
            .offset(y: animate ? 0 : 20)
            .animation(.easeOut(duration: 0.5), value: animate)
            .onAppear { scrollOffset = 0 }
            .background(
                GeometryReader { geo in
                    Color.clear
                        .preference(key: OffsetKey.self, value: geo.frame(in: .global).minY)
                }
            )
            .onPreferenceChange(OffsetKey.self) { value in
                scrollOffset = value
            }
        }
        .onAppear {
            animate = true
            showCards = true
        }
        .preferredColorScheme(.light)
        .environment(\.layoutDirection, .rightToLeft)
    }
}

struct OffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct TopCard: View {
    let title: String
    let value: String
    let icon: String
    let bg: Color
    let border: Color
    let textColor: Color

    @State private var isPressed = false
    @State private var isHovered = false

    var blurView: some View {
        VisualEffectBlur()
    }

    var body: some View {
        VStack(alignment: .trailing, spacing: 8) {

            HStack {
                Spacer()
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(textColor)
            }

            Text(title)
                .font(.system(size: 14))
                .foregroundColor(.gray)

            Text(value)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(textColor)
        }
        .padding(18)
        .frame(maxWidth: .infinity)
        .background(
            ZStack {
                blurView
                bg.opacity(0.4)
            }
        )
        .cornerRadius(22)
        .scaleEffect(isPressed ? 0.95 : 1.0)
        .scaleEffect(isHovered ? 1.03 : 1.0)
        .animation(.easeOut(duration: 0.2), value: isHovered)
        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isPressed)
        .onTapGesture {
            isPressed = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                isPressed = false
            }
        }
        .onHover { hovering in
            isHovered = hovering
        }
    }
}

struct SimilarReportRow: View {
    let percent: String
    let title: String
    let subtitle: String

    @State private var isHovered = false
    @State private var isPressed = false

    var body: some View {
        HStack {
            // LEFT SIDE — Icon first
            ZStack {
                Circle()
                    .fill(Color(red: 0.90, green: 1.0, blue: 0.92))
                    .frame(width: 48, height: 48)

                Image(systemName: "doc.text")
                    .foregroundColor(Color.green)
            }

            // MIDDLE — Title + Subtitle
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)

                Text(subtitle)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
            }

            Spacer()

            // RIGHT SIDE — Percent block
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 6) {
                    Text(percent)
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(Color.green)

                    Image(systemName: "eye")
                        .foregroundColor(.gray)
                }

                Text("تطابق")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 8)
        .scaleEffect(isPressed ? 0.95 : 1.0)
        .scaleEffect(isHovered ? 1.03 : 1.0)
        .animation(.easeOut(duration: 0.2), value: isHovered)
        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isPressed)
        .onTapGesture {
            isPressed = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                isPressed = false
            }
        }
        .onHover { hovering in
            isHovered = hovering
        }
        .transition(.move(edge: .trailing).combined(with: .opacity))
    }
}

struct AnomalyItem: View {
    let number: Int
    let text: String
    @State private var animate = false
    @State private var isHovered = false
    @State private var isPressed = false

    var body: some View {
        HStack {
            VStack(alignment: .center) {
                Text(text)
                    .font(.system(size: 15))
                    .multilineTextAlignment(.center)
            }

            Spacer()

            Circle()
                .fill(Color(red: 1.0, green: 0.9, blue: 0.4))
                .frame(width: 34, height: 34)
                .overlay(
                    Text("\(number)")
                        .font(.system(size: 16, weight: .bold))
                )
        }
        
    }
}

struct PatternRow: View {
    let title: String
    let subtitle: String
    let icon: String
    @State private var isHovered = false
    @State private var isPressed = false

    var body: some View {
        HStack(spacing: 12) {

            // Placeholder spacing where the icon used to sit
            Rectangle()
                .fill(Color.clear)
                .frame(width: 60, height: 40)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 17, weight: .semibold))

                Text(subtitle)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 6)
    }
}

#Preview {
    ReportResultsView()
}
// Placeholder DashboardView for NavigationLink destination
struct DashboardView: View {
    var body: some View {
        Text("Dashboard")
            .font(.largeTitle)
            .padding()
    }
}
struct VisualEffectBlur: NSViewRepresentable {
    func makeNSView(context: Context) -> NSVisualEffectView {
        let view = NSVisualEffectView()
        view.blendingMode = .behindWindow
        view.material = .sidebar
        view.state = .active
        return view
    }
    func updateNSView(_ nsView: NSVisualEffectView, context: Context) {}
}


private var anomaliesCard: some View {
    VStack(alignment: .trailing, spacing: 16) {
        HStack {
            Text("الشذوذات المكتشفة")
                .font(.system(size: 20, weight: .bold))
            Spacer()
        }

        VStack(spacing: 14) {
            AnomalyItem(number: 1, text: "ارتفاع حاد بنسبة 45% في البلاغات خلال الأسبوع الماضي")
            AnomalyItem(number: 2, text: "تكرار غير طبيعي لنفس الموقع (5 بلاغات)")
            AnomalyItem(number: 3, text: "تزامن مع أحداث محلية غير موثقة")
        }
        .padding()
        .background(Color(red: 1.0, green: 0.98, blue: 0.87))
        .cornerRadius(26)
    }
}

private var patternsCard: some View {
    VStack(alignment: .trailing, spacing: 12) {

        // العنوان يبقى فوق
        Text("تحليل الأنماط")
            .font(.system(size: 20, weight: .bold))
            .padding(.trailing)

        // الكارد تحته مباشرة
        VStack(spacing: 12) {
            PatternRow(title: "نمط زمني", subtitle: "تكرار في أوقات المساء (8-11 مساءً)", icon: "")
            PatternRow(title: "نمط جغرافي", subtitle: "تركز في المنطقة الشمالية", icon: "")
            PatternRow(title: "نمط سلوكي", subtitle: "ارتباط مع فعاليات رياضية", icon: "")
        }
        .padding()
        .background(Color(red: 0.96, green: 1, blue: 0.97))
        .cornerRadius(26)
    }
}
