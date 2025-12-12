//
//  AnalysisStepsView.swift
//  MAFAD
//

import SwiftUI

struct ProcessingCircle: View {
    @State private var rotation: Double = 0
    @State private var scale: CGFloat = 0.8

    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: 0.7)
                .stroke(Color("MainColor"), style: StrokeStyle(lineWidth: 3, lineCap: .round))
                .frame(width: 52, height: 52)
                .rotationEffect(.degrees(rotation))
                .onAppear {
                    withAnimation(.linear(duration: 1).repeatForever(autoreverses: false)) {
                        rotation = 360
                    }
                }
            Circle()
                .fill(Color("MainColor"))
                .frame(width: 12, height: 12)
                .scaleEffect(scale)
                .onAppear {
                    withAnimation(.easeInOut(duration: 0.6).repeatForever(autoreverses: true)) {
                        scale = 1.3
                    }
                }
        }
    }
}

struct AnalysisStepsView: View {
    let reportName: String
    @State private var step = -1
    @State private var isHovering = false
    @Environment(\.dismiss) var dismiss

    let steps = [
        ("تحليل البلاغ الأساسي", "Incident Analysis"),
        ("استرجاع البلاغات المشابهة", "Similar Case Retrieval (RAG)"),
        ("اكتشاف الأنماط", "Pattern Detection"),
        ("رصد البلاغات غير المغلقة", "Unresolved Case Tracking"),
        ("التوصيات الأمنية", "AI Security Recommendation"),
        ("توقع مستوى الخطورة", "Risk Prediction"),
        ("بناء خلاصة التحليل", "Final Insights")
    ]

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                let maxCardWidth: CGFloat = min(520, geometry.size.width - 40)
                ScrollView {
                    VStack(spacing: 30) {
                        VStack(spacing: 5) {
                            Image(systemName: "shield.fill")
                                .resizable()
                                .frame(width: 70, height: 70)
                                .foregroundColor(Color("MainColor"))
                            Text("مَفاد")
                                .font(.system(size: 28, weight: .bold))
                            Text("Mafad")
                                .font(.system(size: 18))
                                .foregroundColor(.gray)
                            Text("جاري تحليل البلاغ")
                                .font(.system(size: 25))
                        }
                        
                        VStack(spacing: 4) {
                            Text("رمز البلاغ :")
                                .font(.system(size: 16, weight: .medium))
                            Text(reportName)
                                .font(.system(size: 16))
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        
                        ZStack(alignment: .topTrailing) {
                            RoundedRectangle(cornerRadius: 26)
                                .fill(.white).opacity(0.35)
                                .frame(width: maxCardWidth)
                                .shadow(color: Color.black.opacity(0.06), radius: 8, y: 4)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 26)
                                        .stroke(Color("MainColor").opacity(0.20), lineWidth: 1.2)
                                )
                            
                            VStack(alignment: .trailing, spacing: 36) {
                                ForEach(steps.indices, id: \.self) { i in
                                    HStack(alignment: .center, spacing: 16) {
                                        ZStack {
                                            if i < steps.count - 1 {
                                                Rectangle()
                                                    .fill(step > i ? Color("MainColor") : Color("MainColor").opacity(0.3))
                                                    .frame(width: 2, height: 80)
                                                    .offset(x: 0, y: 42)
                                                    .animation(.easeInOut(duration: 0.5), value: step)
                                            }
                                            
                                            ZStack {
                                                Circle()
                                                    .stroke(Color("MainColor").opacity(0.35), lineWidth: 3)
                                                    .frame(width: 52, height: 52)
                                                
                                                if step == i {
                                                    ProcessingCircle()
                                                        .transition(.opacity)
                                                }
                                                
                                                if step > i {
                                                    Circle()
                                                        .fill(Color("MainColor"))
                                                        .frame(width: 52, height: 52)
                                                        .transition(.scale)
                                                    Image(systemName: "checkmark")
                                                        .font(.system(size: 19, weight: .bold))
                                                        .foregroundColor(.white)
                                                        .transition(.scale)
                                                }
                                            }
                                        }
                                        .frame(width: 60)
                                        
                                        VStack(alignment: .trailing, spacing: 6) {
                                            Text(steps[i].0)
                                                .font(.system(size: 18, weight: .semibold))
                                                .foregroundColor(Color("MainColor"))
                                                .multilineTextAlignment(.trailing)
                                            Text(steps[i].1)
                                                .font(.system(size: 14))
                                                .foregroundColor(.gray)
                                                .multilineTextAlignment(.trailing)
                                        }
                                        Spacer(minLength: 0)
                                    }
                                    .frame(maxWidth: maxCardWidth - 8, alignment: .trailing)
                                    .padding(.horizontal, 12)
                                }
                            }
                            .padding(.vertical, 30)
                            .padding(.horizontal, 20)
                            .frame(width: maxCardWidth, alignment: .trailing)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.top, 10)
                        
                        NavigationLink(destination: ReportResultsView()) {
                            HStack(spacing: 8) {
                                Image(systemName: "arrow.left")
                                    .font(.system(size: 18, weight: .medium))
                                Text("عرض النتائج")
                                    .font(.system(size: 20, weight: .medium))
                            }
                            .foregroundColor(.white)
                            .frame(width: 400, height: 50)
                            .background(
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(Color("MainColor"))
                            )
                            .shadow(color: Color("MainColor").opacity(0.3), radius: 8, y: 4)
                            .scaleEffect(isHovering ? 1.08 : 1.0)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .disabled(step != steps.count - 1)
                        .opacity(step == steps.count - 1 ? 1 : 0.3)
                        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isHovering)
                        .onHover { hovering in
                            isHovering = hovering && step == steps.count - 1
                        }
                        
                        Spacer(minLength: 40)
                    }
                    .frame(minHeight: geometry.size.height)
                    .frame(maxWidth: .infinity)
                }
            }
            .environment(\.layoutDirection, .rightToLeft)
        }
        .preferredColorScheme(.light)
        .onAppear {
            animate()
        }
    }

    func animate() {
        for i in 0..<steps.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 0.7) {
                withAnimation(.easeInOut(duration: 0.5)) {
                    step = i
                }
            }
        }
    }
}

#Preview {
    AnalysisStepsView(reportName: "3042#")
}
