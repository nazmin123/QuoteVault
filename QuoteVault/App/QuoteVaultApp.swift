//
//  QuoteVaultApp.swift
//  QuoteVault
//
//  Created by Nazmin Parween on 13/01/26.
//

import SwiftUI

@main
struct QuoteVaultApp: App {

    @StateObject private var authVM = AuthViewModel()
    @StateObject private var settings = AppSettings()
    @StateObject private var alertManager = AppAlertManager.shared
    // Scoped alert managers per feature
        @StateObject private var profileAlert = AppAlertManager()
        @StateObject private var collectionAlert = AppAlertManager()
        @StateObject private var favoritesAlert = AppAlertManager()

    var body: some Scene {
        WindowGroup {
            SplashView()
                .environmentObject(authVM)
                .environmentObject(settings)
                .environmentObject(alertManager)
                .preferredColorScheme(settings.isDarkMode ? .dark : .light)
                .accentColor(
                    AccentTheme(rawValue: settings.accentColor)?.color ?? .blue
                )
                .onOpenURL { url in
                    if url.absoluteString.contains("reset-password") {
                        authVM.isAuthenticated = true
                    }
                }
                .alert(item: $alertManager.alertData) { data in
                    if let secondary = data.secondaryButton {
                        return Alert(
                            title: Text(data.title),
                            message: Text(data.message),
                            primaryButton: data.primaryButton,
                            secondaryButton: secondary
                        )
                    } else {
                        return Alert(
                            title: Text(data.title),
                            message: Text(data.message),
                            dismissButton: data.primaryButton
                        )
                    }
                }

        }
    }
}

