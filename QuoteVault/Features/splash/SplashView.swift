//
//  SplashView.swift
//  QuoteVault
//
//  Created by Nazmin Parween on 16/01/26.
//

import SwiftUI

struct SplashView: View {

    @EnvironmentObject var authVM: AuthViewModel
    @EnvironmentObject var settings: AppSettings
    @State private var isActive = false
    @State private var logoScale: CGFloat = 0.6
    @State private var logoOpacity: Double = 0.0
    @State private var pulse = false

    var body: some View {
        if isActive {
            RootView()
        } else {
            ZStack {
                Color(.systemBackground)
                    .ignoresSafeArea()

                VStack(spacing: 20) {

                    Image(systemName: "quote.bubble.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 90, height: 90)
                    
                        .foregroundStyle(
                            AccentTheme(rawValue: settings.accentColor)?.color ?? .blue
                        )

                        .scaleEffect(logoScale)
                        .opacity(logoOpacity)
                        .scaleEffect(pulse ? 1.05 : 1.0)

                    Text("QuoteVault")
                        .font(.largeTitle.bold())
                        .opacity(logoOpacity)

                    ProgressView()
                        .opacity(logoOpacity)
                }
            }
            .task {
                await animateAndLaunch()
            }
        }
    }

    private func animateAndLaunch() async {

        // Entry animation
        withAnimation(.easeOut(duration: 0.8)) {
            logoScale = 1.0
            logoOpacity = 1.0
        }

        // Pulse animation
        withAnimation(
            .easeInOut(duration: 1.0).repeatForever(autoreverses: true)
        ) {
            pulse = true
        }

        // Splash duration
        try? await Task.sleep(nanoseconds: 1_600_000_000)

        await MainActor.run {
            Task {
                await authVM.restoreSessionIfNeeded()
            }
        }


        withAnimation(.easeInOut(duration: 0.4)) {
            isActive = true
        }
    }
}

