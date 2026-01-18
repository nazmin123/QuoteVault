//
//  ForgotPasswordView.swift
//  QuoteVault
//
//  Created by Nazmin Parween on 13/01/26.
//

import SwiftUI

struct ForgotPasswordView: View {

    @EnvironmentObject var authVM: AuthViewModel
    @Environment(\.dismiss) var dismiss

    @State private var email = ""
    @State private var success = false

    var body: some View {
        VStack(spacing: 24) {

            Text("Reset Password")
                .font(.largeTitle.bold())

            Text("Enter your email to receive a password reset link.")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)

            TextField("Email", text: $email)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .textFieldStyle(.roundedBorder)

            if let error = authVM.errorMessage {
                Text(error).foregroundColor(.red)
            }

            if success {
                Text("Check your email for the reset link.")
                    .foregroundColor(.green)
            }

            Button("Send Reset Link") {
                Task {
                    await authVM.sendPasswordReset(email: email)
                    success = authVM.errorMessage == nil
                }
            }
            .buttonStyle(.borderedProminent)
            .disabled(email.isEmpty || authVM.isLoading)

            Spacer()
        }
        .padding()
        .navigationTitle("Forgot Password")
    }
}

