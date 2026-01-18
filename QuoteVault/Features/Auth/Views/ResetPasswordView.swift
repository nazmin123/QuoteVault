//
//  ResetPasswordView.swift
//  QuoteVault
//
//  Created by Nazmin Parween on 14/01/26.
//

import SwiftUI

struct ResetPasswordView: View {

    @EnvironmentObject var authVM: AuthViewModel

    @State private var password = ""
    @State private var confirmPassword = ""

    var body: some View {
        VStack(spacing: 24) {

            Text("Set New Password")
                .font(.largeTitle.bold())

            SecureField("New Password", text: $password)
                .textFieldStyle(.roundedBorder)

            SecureField("Confirm Password", text: $confirmPassword)
                .textFieldStyle(.roundedBorder)

            if let error = authVM.errorMessage {
                Text(error).foregroundColor(.red)
            }

            Button("Update Password") {
                guard password == confirmPassword else {
                    authVM.errorMessage = "Passwords do not match"
                    return
                }

                Task {
                    await authVM.updatePassword(newPassword: password)
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

