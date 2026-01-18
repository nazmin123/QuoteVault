//
//  LoginView.swift
//  QuoteVault
//
//  Created by Nazmin Parween on 13/01/26.
//

import SwiftUI


struct LoginView: View {
@EnvironmentObject var authVM: AuthViewModel
@State private var email = ""
@State private var password = ""
@State private var isLoading = false


var body: some View {
VStack(spacing: 20) {
Text("QuoteVault")
.font(.largeTitle.bold())


TextField("Email", text: $email)
.textInputAutocapitalization(.never)
.keyboardType(.emailAddress)
.textFieldStyle(.roundedBorder)


SecureField("Password", text: $password)
.textFieldStyle(.roundedBorder)

    if let error = authVM.errorMessage {
                   Text(error)
                       .foregroundColor(.red)
                       .multilineTextAlignment(.center)
               }

    Button("Login") {
        // Auth logic
        Task {
                           await authVM.signIn(
                               email: email,
                               password: password
                           )
                       }
    }
.buttonStyle(.borderedProminent)
.disabled(authVM.isLoading)


NavigationLink("Forgot Password?", destination: ForgotPasswordView())
NavigationLink("Create Account", destination: SignupView())
}
.padding()
}
}
