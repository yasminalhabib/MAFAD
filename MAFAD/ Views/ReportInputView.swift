//
//  ReportInputView.swift
//  MAFAD
//

import SwiftUI

struct ReportInputView: View {
    @StateObject private var viewModel = ReportInputViewModel()
    @State private var navigateToAnalysis = false
    @State private var isHovered = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 25) {
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
                
                TextField("أدخل رمز البلاغ", text: $viewModel.reportCode)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.gray.opacity(0.8))
                    .textFieldStyle(PlainTextFieldStyle())
                    .frame(height: 44)
                    .padding(.horizontal, 20)
                    .frame(maxWidth: 500)
                    .frame(height: 40)
                    .background(
                        RoundedRectangle(cornerRadius: 35)
                            .fill(Color.white)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 35)
                            .stroke(Color("MainColor"), lineWidth: 3)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 35)
                            .stroke(Color("MainColor"), lineWidth: 2)
                            .padding(3)
                    )
                    .shadow(color:Color("MainColor").opacity(0.15), radius: 8, x: 0, y: 4)
                    .scaleEffect(isHovered ? 1.01 : 1.0)
                    .animation(.easeOut(duration: 0.2), value: isHovered)
                    .onHover { hovering in
                        isHovered = hovering
                    }
                    .padding(.horizontal, 40)
                    .padding(.top, 10)
                
                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.system(size: 14))
                        .padding(.top, -15)
                }
                
                Button {
                    Task {
                        let success = await viewModel.validateAndProceed()
                        if success {
                            navigateToAnalysis = true
                        }
                    }
                } label: {
                    ZStack {
                        if viewModel.isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        } else {
                            Text("بدء التحليل →")
                                .font(.system(size: 15, weight: .medium))
                        }
                    }
                    .frame(width:500, height: 40)
                    .background(Color("MainColor"))
                    .foregroundColor(.white)
                    .cornerRadius(25)
                }
                .buttonStyle(.plain)
                .disabled(viewModel.isLoading)
                .opacity(viewModel.isLoading ? 0.7 : 1.0)
                .padding(.top, -10)
                .navigationDestination(isPresented: $navigateToAnalysis) {
                    AnalysisStepsView(reportName: viewModel.reportCode)
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
