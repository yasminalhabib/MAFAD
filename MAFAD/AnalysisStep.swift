//
//  AnalysisStep.swift
//  MAFAD
//
//  Created by noura on 10/12/2025.
//

import SwiftUI

struct AnalysisStepsView: View {

    let reportName: String
    @State private var step = -1
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

                        // Back button
                        HStack {
                            Button { dismiss() } label: {
                                Image(systemName: "chevron.left")
                                    .font(.system(size: 22, weight: .medium))
                                    .foregroundColor(Color("MainColor"))
                            }
                            Spacer()
                        }
                        .padding(.horizontal, 20)

                        // Logo + Titles
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

                        // Report code centered
                        VStack(spacing: 4) {
                            Text("رمز البلاغ :")
                                .font(.system(size: 16, weight: .medium))
                            
                            Text(reportName)
                                .font(.system(size: 16))
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)

                        // ----------- CARD -----------
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

                                        // ---- CIRCLE + LINE (RIGHT) ----
                                        ZStack {
                                            // vertical line under circle
                                            if i < steps.count - 1 {
                                                Rectangle()
                                                    .fill(step > i ? Color("MainColor") : Color("MainColor").opacity(0.3))
                                                    .frame(width: 2, height: 80)
                                                    .offset(x: 0, y: 42)
                                                    .animation(.easeInOut(duration: 0.5), value: step)
                                            }

                                            // circle
                                            ZStack {
                                                Circle()
                                                    .stroke(Color("MainColor").opacity(0.35), lineWidth: 3)
                                                    .frame(width: 52, height: 52)

                                                if step >= i {
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

                                        // ---- TEXTS NEXT TO CIRCLE ----
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

                        // Show Results Button
                        Button { } label: {
                            Text("عرض النتائج ←")
                                .font(.system(size: 20, weight: .medium))
                                .frame(width: 320, height: 50)
                                .background(Color("MainColor"))
                                .foregroundColor(.white)
                                .cornerRadius(25)
                        }
                        .opacity(step == steps.count - 1 ? 1 : 0.3)
                        .disabled(step != steps.count - 1)

                        Spacer(minLength: 40)
                    }
                    .frame(minHeight: geometry.size.height)
                    .frame(maxWidth: .infinity)
                }
            }
            .environment(\.layoutDirection, .rightToLeft)
        }
        .preferredColorScheme(.light)
        .onAppear { animate() }
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

