//
//  ProfileSettingsView.swift
//  QuoteVault
//
//  Created by Nazmin Parween on 13/01/26.
//
import SwiftUI
import PhotosUI

struct ProfileSettingsView: View {
    
    @EnvironmentObject var authVM: AuthViewModel
    @EnvironmentObject var settings: AppSettings
    @StateObject private var viewModel = ProfileSettingsViewModel()
    @State private var selectedPhoto: PhotosPickerItem?
    
    var body: some View {
        Form {
            
            // MARK: - Profile
            Section {
                HStack(spacing: 16) {
                    
                    // Tappable profile image
                    PhotosPicker(
                        selection: $selectedPhoto,
                        matching: .images,
                        photoLibrary: .shared()
                    ) {
                        ZStack {
                            if let url = viewModel.avatarURL {
                                AsyncImage(url: url) { image in
                                    image.resizable()
                                        .scaledToFill()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 80, height: 80)
                                .clipShape(Circle())
                            } else {
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                    .foregroundColor(.accentColor)
                            }
                            
                            if viewModel.isUploadingImage {
                                ProgressView()
                            }
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(viewModel.userName)
                            .font(.headline)
                        
                        Text(viewModel.email)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .onChange(of: selectedPhoto) { newItem in
                guard let item = newItem else { return }
                
                // 🔴 CRITICAL: copy immediately
                Task {
                    await viewModel.uploadProfileImage(from: item)
                    
                    // 🔴 MUST reset on View side
                    await MainActor.run {
                        selectedPhoto = nil
                    }
                } 
            }
                
                // MARK: - Appearance
                Section("Appearance") {
                    Toggle("Dark Mode", isOn: $settings.isDarkMode)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Font Size: \(Int(settings.fontSize))")
                        Slider(value: $settings.fontSize, in: 14...26, step: 1)
                    }
                    
                    Picker("Accent Color", selection: $settings.accentColor) {
                        ForEach(AccentTheme.allCases) { theme in
                            Text(theme.title).tag(theme.rawValue)
                        }
                    }
                }
                
                // MARK: - Notifications
                Section("Notifications") {
                    Toggle("Daily Quote", isOn: $settings.dailyQuoteEnabled)
                        .onChange(of: settings.dailyQuoteEnabled) { enabled in
                            Task {
                                if enabled {
                                    let granted = await QuoteNotificationManager.requestPermission()
                                    if !granted {
                                        settings.dailyQuoteEnabled = false
                                    }
                                } else {
                                    QuoteNotificationManager.cancelDailyQuote()
                                }
                            }
                        }
                    
                    if settings.dailyQuoteEnabled {
                        DatePicker(
                            "Time",
                            selection: Binding(
                                get: { settings.notificationTime },
                                set: {
                                    settings.updateNotificationTime($0)
                                    QuoteNotificationManager.scheduleDailyQuote(
                                        at: settings.dailyQuoteHour,
                                        minute: settings.dailyQuoteMinute,
                                        quote: Quote.defaultQuote
                                    )
                                }
                            ),
                            displayedComponents: .hourAndMinute
                        )
                    }
                }
                
                // MARK: - Logout
                Section {
                    Button(role: .destructive) {
                        Task {
                            await authVM.signOut()
                        }
                    } label: {
                        Text("Logout")
                    }
                }
            }
            .navigationTitle("Profile & Settings")
            .task {
                await viewModel.loadProfile()
            }
        }
    }
    


