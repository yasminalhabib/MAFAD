//
//  ReportName.swift
//  MAFAD
//
//  Created by noura on 10/12/2025.
//
import SwiftUI

struct ReportInputView: View {
    @State private var reportName = ""
    @State private var goNext = false
    @State private var isHovered = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 25) {
                
                // Logo & Titles
                Image(systemName: "shield.fill")
                    .font(.system(size: 70))
                    .foregroundColor(Color("MainColor"))
                    .padding(-10)
                
                Text("مَفاد")
                    .foregroundColor(Color("MainColor"))
                    .font(.system(size: 28, weight: .semibold))
                
                Text("Mafad")
                    .foregroundColor(.gray)
                    .font(.system(size: 10, weight: .medium))
                    .multilineTextAlignment(.center)
                    .padding(-20)
                
                Text("منصة التحليل الامني الذكي")
                    .font(.system(size: 28, weight: .semibold))
                    .padding()
                
                Text("ادخل رمز البلاغ لبدء التحليل")
                    .font(.system(size: 12, weight: .medium))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)
                    .padding(-25)
                
                // Search Bar with Green Border
                TextField("أدخل رمز البلاغ", text: $reportName)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.gray.opacity(0.8))
                    .textFieldStyle(PlainTextFieldStyle())
                    .frame(height: 55)
                    .onSubmit {
                        goNext = true
                    }
                .padding(.horizontal, 20)
                .frame(maxWidth: 300)
                .frame(height: 40)
                .background(
                    RoundedRectangle(cornerRadius: 50)
                        .fill(Color.white)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 43)
                        .stroke(Color("MainColor"), lineWidth: 3)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 43)
                        .stroke(Color("MainColor"), lineWidth: 2)
                        .padding(3)
                )
                .shadow(color: Color("MainColor").opacity(0.15), radius: 8, x: 0, y: 4)
                .scaleEffect(isHovered ? 1.01 : 1.0)
                .animation(.easeOut(duration: 0.2), value: isHovered)
                .onHover { hovering in
                    isHovered = hovering
                }
                .padding(.horizontal, 40)
                .padding(.top, 10)
                
                // Button
                Button {
                    goNext = true
                } label: {
                    Text("بدء التحليل ←")
                        .font(.system(size: 15, weight: .medium))
                        .frame(width: 300, height: 40)
                        .background(Color("MainColor"))
                        .foregroundColor(.white)
                        .cornerRadius(25)
                }
                .buttonStyle(.plain)
                .focusable(false)
                .padding(.top, -10)
                
                // Navigation
                .navigationDestination(isPresented: $goNext) {
                    AnalysisStepsView(reportName: reportName)
                }
            }
            .preferredColorScheme(.light)
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ReportInputView()
}
