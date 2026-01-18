//
//  SessionManager.swift
//  QuoteVault
//
//  Created by Nazmin Parween on 13/01/26.
//
import SwiftUI
import Combine

final class SessionManager: ObservableObject {
@Published var isAuthenticated: Bool = false
@Published var userName: String = ""
@Published var email: String = ""


func signIn() {
isAuthenticated = true
}


func signOut() {
isAuthenticated = false
}
}
