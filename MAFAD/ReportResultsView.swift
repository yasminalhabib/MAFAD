//
//  ReportResultsView.swift
//  MAFAD
//

import SwiftUI

struct ReportResultsView: View {
    @State private var animate = false
    @State private var showCards = false
    @State private var isHomeHovered = false
    @State private var isDashboardHovered = false
    @State private var isReturnHovered = false
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                
                // TOP BAR
                HStack {
                    HStack(spacing: 12) {
                        ZStack {
                            Circle()
                                .fill(Color("MainColor"))
                                .frame(width: 48, height: 48)
                            Image(systemName: "shield.fill")
                                .foregroundColor(.white)
                                .font(.system(size: 22))
                        }
                        Text("مفاد")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(Color("MainColor"))
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 32) {
                        HStack(spacing: 8) {
                            Image(systemName: "house")
                                .font(.system(size: 16))
                            Text("الرئيسية")
                                .font(.system(size: 16))
                        }
                        .foregroundColor(.gray)
                        .scaleEffect(isHomeHovered ? 1.05 : 1.0)
                        .animation(.easeOut(duration: 0.2), value: isHomeHovered)
                        .onHover { isHomeHovered = $0 }
                        
                        HStack(spacing: 8) {
                            Image(systemName: "chart.bar.fill")
                                .font(.system(size: 16))
                            Text("لوحة التحكم")
                                .font(.system(size: 16))
                        }
                        .foregroundColor(.gray)
                        .scaleEffect(isDashboardHovered ? 1.05 : 1.0)
                        .animation(.easeOut(duration: 0.2), value: isDashboardHovered)
                        .onHover { isDashboardHovered = $0 }
                    }
                }
                .padding(.horizontal, 32)
                .padding(.vertical, 16)
                .background(Color.white)
                .shadow(color: Color.black.opacity(0.03), radius: 2, y: 1)
                
                // MAIN CONTENT
                VStack(spacing: 32) {
                    
                    // HEADER
                    HStack(alignment: .top) {
                        VStack(alignment: .trailing, spacing: 6) {
                            HStack(spacing: 8) {
                                Text("نتائج التحليل")
                                    .font(.system(size: 14))
                                    .foregroundColor(.gray)
                                Image(systemName: "doc.text")
                                    .font(.system(size: 14))
                                    .foregroundColor(.gray)
                            }
                            Text("بلاغ #1734")
                                .font(.system(size: 32, weight: .bold))
                                .foregroundColor(.black)
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    .padding(.horizontal, 32)
                    .padding(.top, 32)
                    
                    // TOP 3 CARDS
                    HStack(spacing: 16) {
                        TopCardView(
                            title: "الإجراء الموصى به",
                            value: "تصعيد فوري",
                            icon: "bolt.fill",
                            bg: Color(red: 1, green: 0.98, blue: 0.88),
                            border: Color(red: 0.95, green: 0.75, blue: 0.25),
                            iconCol: Color(red: 0.2, green: 0.65, blue: 0.55)
                        )
                        .opacity(showCards ? 1 : 0)
                        .offset(y: showCards ? 0 : 20)
                        .animation(.easeOut(duration: 0.5).delay(0.1), value: showCards)
                        
                        TopCardView(
                            title: "درجة المخاطرة",
                            value: "78%",
                            icon: "shield.fill",
                            bg: Color(red: 0.93, green: 0.98, blue: 0.95),
                            border: Color(red: 0.2, green: 0.65, blue: 0.55),
                            iconCol: Color(red: 0.2, green: 0.65, blue: 0.55)
                        )
                        .opacity(showCards ? 1 : 0)
                        .offset(y: showCards ? 0 : 20)
                        .animation(.easeOut(duration: 0.5).delay(0.2), value: showCards)
                        
                        TopCardView(
                            title: "مستوى الخطورة",
                            value: "مرتفع",
                            icon: "exclamationmark.triangle.fill",
                            bg: Color(red: 1, green: 0.95, blue: 0.95),
                            border: Color(red: 0.85, green: 0.35, blue: 0.35),
                            iconCol: Color(red: 0.85, green: 0.35, blue: 0.35)
                        )
                        .opacity(showCards ? 1 : 0)
                        .offset(y: showCards ? 0 : 20)
                        .animation(.easeOut(duration: 0.5).delay(0.3), value: showCards)
                    }
                    .padding(.horizontal, 32)
                    
                    // SIMILAR REPORTS
                    VStack(alignment: .trailing, spacing: 16) {
                        HStack {
                            Spacer()
                            Text("البلاغات المشابهة")
                                .font(.system(size: 20, weight: .bold))
                            Image(systemName: "target")
                                .font(.system(size: 20))
                                .foregroundColor(Color("MainColor"))
                        }
                        .padding(.horizontal, 32)
                        
                        VStack(spacing: 0) {
                            SimilarRowView(percent: "92%", id: "2847#", desc: "تجمع غير مرخص", date: "10-01-2024")
                            Divider().padding(.horizontal, 20)
                            SimilarRowView(percent: "87%", id: "2651#", desc: "إزعاج عام", date: "05-01-2024")
                            Divider().padding(.horizontal, 20)
                            SimilarRowView(percent: "78%", id: "2490#", desc: "مخالفة بنائية", date: "28-12-2023")
                            Divider().padding(.horizontal, 20)
                            SimilarRowView(percent: "71%", id: "2312#", desc: "تجمع غير مرخص", date: "15-12-2023")
                        }
                        .padding(.vertical, 20)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color(red: 0.97, green: 0.99, blue: 0.98))
                        )
                        .padding(.horizontal, 32)
                    }
                    .opacity(animate ? 1 : 0)
                    .animation(.easeOut(duration: 0.6).delay(0.4), value: animate)
                    
                    // ANOMALIES + PATTERNS
                    HStack(alignment: .top, spacing: 20) {
                        
                        // ANOMALIES
                        VStack(alignment: .trailing, spacing: 16) {
                            HStack {
                                Spacer()
                                Text("الشذوذات المكتشفة")
                                    .font(.system(size: 18, weight: .bold))
                                Image(systemName: "exclamationmark.triangle.fill")
                                    .font(.system(size: 18))
                                    .foregroundColor(Color(red: 0.95, green: 0.7, blue: 0.25))
                            }
                            
                            VStack(spacing: 12) {
                                AnomalyRowView(num: "1", txt: "ارتفاع حاد بنسبة 45% في البلاغات خلال الأسبوع الماضي")
                                AnomalyRowView(num: "2", txt: "تكرار غير طبيعي لنفس الموقع (5 بلاغات)")
                                AnomalyRowView(num: "3", txt: "تزامن مع أحداث محلية غير موثقة")
                            }
                            .padding(20)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .strokeBorder(Color.gray.opacity(0.15), lineWidth: 1)
                            )
                        }
                        
                        // PATTERNS
                        VStack(alignment: .trailing, spacing: 16) {
                            HStack {
                                Spacer()
                                Text("تحليل الأنماط")
                                    .font(.system(size: 18, weight: .bold))
                                Image(systemName: "chart.line.uptrend.xyaxis")
                                    .font(.system(size: 18))
                                    .foregroundColor(Color("MainColor"))
                            }
                            
                            VStack(spacing: 16) {
                                PatternRowView(ico: "clock.fill", ttl: "نمط زمني", sub: "تكرار في أوقات المساء (8-11 مساءً)")
                                PatternRowView(ico: "location.fill", ttl: "نمط جغرافي", sub: "تركز في المنطقة الشمالية")
                                PatternRowView(ico: "target", ttl: "نمط سلوكي", sub: "ارتباط مع فعاليات رياضية")
                            }
                            .padding(20)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .strokeBorder(Color.gray.opacity(0.15), lineWidth: 1)
                            )
                        }
                    }
                    .padding(.horizontal, 32)
                    .opacity(animate ? 1 : 0)
                    .animation(.easeOut(duration: 0.6).delay(0.6), value: animate)
                    
                    // RETURN BUTTON
                    NavigationLink(destination: MafadDashboardView()) {
                        HStack(spacing: 8) {
                            Image(systemName: "arrow.right")
                                .font(.system(size: 16, weight: .medium))
                            Text("رجوع للوحة التحكم")
                                .font(.system(size: 18, weight: .medium))
                        }
                        .foregroundColor(Color("MainColor"))
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(Color.white.opacity(0.01))
                        .overlay(
                            RoundedRectangle(cornerRadius: 50)
                                .strokeBorder(Color("MainColor"), lineWidth: 2)
                        )
                        .scaleEffect(isReturnHovered ? 1.02 : 1.0)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .animation(.easeOut(duration: 0.2), value: isReturnHovered)
                    .onHover { isReturnHovered = $0 }
                    .padding(.horizontal, 32)
                    .padding(.vertical, 40)
                }
            }
        }
        .background(Color(red: 0.98, green: 0.98, blue: 0.98))
        .onAppear {
            animate = true
            showCards = true
        }
        .environment(\.layoutDirection, .rightToLeft)
    }
}

// MARK: - Top Card
struct TopCardView: View {
    let title, value, icon: String
    let bg, border, iconCol: Color
    @State private var h = false
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 12) {
            HStack {
                Spacer()
                ZStack {
                    Circle()
                        .fill(bg)
                        .frame(width: 40, height: 40)
                    Image(systemName: icon)
                        .font(.system(size: 18))
                        .foregroundColor(iconCol)
                }
            }
            Text(title)
                .font(.system(size: 13))
                .foregroundColor(.gray)
            Text(value)
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.black)
        }
        .padding(20)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(bg)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(border, lineWidth: 2)
        )
        .scaleEffect(h ? 1.02 : 1.0)
        .animation(.easeOut(duration: 0.2), value: h)
        .onHover { h = $0 }
    }
}

// MARK: - Similar Row
struct SimilarRowView: View {
    let percent, id, desc, date: String
    @State private var h = false
    
    var body: some View {
        HStack(spacing: 16) {
            VStack(spacing: 4) {
                HStack(spacing: 4) {
                    Image(systemName: "eye.fill")
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                    Text(percent)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color("MainColor"))
                }
                Text("تطابق")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }
            .frame(width: 80)
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 6) {
                Text("بلاغ \(id)")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.black)
                Text("\(desc) • \(date)")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
            
            ZStack {
                Circle()
                    .fill(Color(red: 0.9, green: 0.98, blue: 0.94))
                    .frame(width: 40, height: 40)
                Image(systemName: "doc.text.fill")
                    .font(.system(size: 18))
                    .foregroundColor(Color("MainColor"))
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .scaleEffect(h ? 1.01 : 1.0)
        .animation(.easeOut(duration: 0.2), value: h)
        .onHover { h = $0 }
    }
}

// MARK: - Anomaly Row
struct AnomalyRowView: View {
    let num, txt: String
    @State private var h = false
    
    var body: some View {
        HStack(spacing: 16) {
            Spacer()
            Text(txt)
                .font(.system(size: 14))
                .foregroundColor(.black)
                .multilineTextAlignment(.trailing)
            ZStack {
                Circle()
                    .fill(Color(red: 0.95, green: 0.8, blue: 0.35))
                    .frame(width: 36, height: 36)
                Text(num)
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(.black)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 14)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(red: 1, green: 0.98, blue: 0.88))
        )
        .scaleEffect(h ? 1.01 : 1.0)
        .animation(.easeOut(duration: 0.2), value: h)
        .onHover { h = $0 }
    }
}

// MARK: - Pattern Row
struct PatternRowView: View {
    let ico, ttl, sub: String
    @State private var h = false
    
    var body: some View {
        HStack(spacing: 16) {
            Spacer()
            VStack(alignment: .trailing, spacing: 4) {
                Text(ttl)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.black)
                Text(sub)
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.trailing)
            }
            ZStack {
                Circle()
                    .fill(Color(red: 0.88, green: 0.96, blue: 0.93))
                    .frame(width: 40, height: 40)
                Image(systemName: ico)
                    .font(.system(size: 16))
                    .foregroundColor(Color("MainColor"))
            }
        }
        .scaleEffect(h ? 1.01 : 1.0)
        .animation(.easeOut(duration: 0.2), value: h)
        .onHover { h = $0 }
    }
}

#Preview {
    ReportResultsView()
}
