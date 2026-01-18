//
//  SignupView.swift
//  QuoteVault
//
//  Created by Nazmin Parween on 13/01/26.
//

import SwiftUI

struct SignupView: View {
@State private var name = ""
@State private var email = ""
@State private var password = ""
@EnvironmentObject var authVM: AuthViewModel


var body: some View {
    VStack(spacing: 20) {
        Form {
            TextField("Name", text: $name)
            TextField("Email", text: $email)
            SecureField("Password", text: $password)
            
        }
        Button("Sign Up") {
            // Signup logic
            Task {
                await authVM.signUp(
                    email: email,
                    password: password
                )
            }
        }
        .disabled(authVM.isLoading)
        if authVM.isLoading {
                        ProgressView()
                    }
    }
.navigationTitle("Sign Up")
}
}
