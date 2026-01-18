//
//  AuthViewModel.swift
//  QuoteVault
//
//  Created by Nazmin Parween on 13/01/26.
//

import SwiftUI
import Combine
import Foundation
import Supabase

@MainActor
final class AuthViewModel: ObservableObject {

    @Published var isAuthenticated = false
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let client = SupabaseManager.shared.client

    init() {
        Task { restoreSessionIfNeeded() }
    }

    func restoreSessionIfNeeded() {
           Task {
               do {
                   let session = try await client.auth.session
                   isAuthenticated = session != nil
               } catch {
                   isAuthenticated = false
               }
           }
       }

    func signIn(email: String, password: String) async {
        isLoading = true
        errorMessage = nil

        do {
            try await client.auth.signIn(
                email: email,
                password: password
            )
            isAuthenticated = true
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    func signUp(email: String, password: String) async {
        isLoading = true
        errorMessage = nil

        do {
            try await client.auth.signUp(
                email: email,
                password: password
            )
            isAuthenticated = true
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    func signOut() async {
        do {
            try await client.auth.signOut()
            isAuthenticated = false
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func sendPasswordReset(email: String) async {
        isLoading = true
        errorMessage = nil

        do {
            try await SupabaseManager.shared.client.auth
                .resetPasswordForEmail(
                    email,
                    redirectTo: URL(string: "quotevault://reset-password")!
                )
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    func updatePassword(newPassword: String) async {
        isLoading = true
        errorMessage = nil

        do {
            try await SupabaseManager.shared.client.auth
                .update(user: UserAttributes(password: newPassword))
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

}
