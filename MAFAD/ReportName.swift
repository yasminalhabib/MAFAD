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
                // White Box
            
                    Text("ادخل رمز البلاغ لبدء التحليل")
                        .font(.system(size: 12, weight: .medium))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.gray)
                        .padding(-25)
                
                
                TextField("أدخل رمز البلاغ", text: $reportName)
                                       .multilineTextAlignment(.center)
                                       .font(.system(size: 14, weight: .medium))
                                       .padding()
                                       .frame(width: 300, height: 40) // ← نفس حجم زر “بدء التحليل”
                                       .background(Color.white)
                                       .overlay(
                                           RoundedRectangle(cornerRadius: 25)
                                               .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                                       )
                        .padding()
               
                
                // Button
                Button {
                    goNext = true
                } label: {
                    Text("بدء التحليل ←")
                        .font(.system(size: 15, weight: .medium))
                        .frame(width: 300, height: 40) // ← نفس حجم TextField الآن
                        .background(Color("MainColor"))
                        .foregroundColor(.white)
                        .cornerRadius(25)
                }
                .buttonStyle(.plain)
                .focusable(false)
                .padding(-25)
                // Navigation
                .navigationDestination(isPresented: $goNext) {
                    AnalysisStepsView(reportName: reportName)
                }
                
                Text("عرض البلاغات التي تم تحليلها ←")
                    .font(.system(size: 12, weight: .medium))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color("MainColor"))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(20)
                
            }
           
            .preferredColorScheme(.light)
        }
    }
}

#Preview {
    ReportInputView()
}
