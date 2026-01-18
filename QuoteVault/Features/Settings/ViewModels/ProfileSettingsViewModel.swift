//
//  ProfileSettingsViewModel.swift
//  QuoteVault
//
//  Created by Nazmin Parween on 13/01/26.
//

import SwiftUI
import Combine
import Supabase
import PhotosUI

@MainActor
final class ProfileSettingsViewModel: ObservableObject {

    @Published var userName: String = ""
    @Published var email: String = ""
    @Published var isDarkMode: Bool = false
    @Published var fontSize: Double = 16
    @Published var accentColor: String = "blue"
    @Published var avatarURL: URL?
    @Published var isUploadingImage = false

    private let client = SupabaseManager.shared.client
    private let alertManager = AppAlertManager.shared

    // MARK: - Load Profile

    func loadProfile() async {
        do {
            let user = try await client.auth.user()
            email = user.email ?? ""

            let profile: Profile = try await client
                .from("profiles")
                .select()
                .eq("id", value: user.id)
                .single()
                .execute()
                .value

            userName = profile.name ?? "User"
            avatarURL = profile.avatar_url.flatMap(URL.init)

        } catch {
            alertManager.showAlert(
                title: "Profile Load Failed",
                message: error.localizedDescription
            )
        }
    }

    // MARK: - Save Profile Changes

    func saveChanges() async {
        do {
            let user = try await client.auth.user()

            try await client
                .from("profiles")
                .update([
                    "name": userName
                ])
                .eq("id", value: user.id)
                .execute()

        } catch {
            alertManager.showAlert(
                title: "Save Failed",
                message: error.localizedDescription
            )
        }
    }

    // MARK: - Upload Profile Image

    func uploadProfileImage(from item: PhotosPickerItem?) async {
        guard let item else { return }

        isUploadingImage = true
        defer { isUploadingImage = false }

        do {
            guard
                let data = try await item.loadTransferable(type: Data.self),
                let image = UIImage(data: data),
                let imageData = image.jpegData(compressionQuality: 0.8)
            else {
                alertManager.showAlert(
                    title: "Invalid Image",
                    message: "The selected image could not be processed."
                )
                return
            }

            let user = try await client.auth.user()
            let filePath = "\(user.id).jpg"

            try await client.storage
                .from("avatars")
                .upload(
                    path: filePath,
                    file: imageData,
                    options: FileOptions(
                        contentType: "image/jpeg",
                        upsert: true
                    )
                )

            let publicURL = try client.storage
                .from("avatars")
                .getPublicURL(path: filePath)

            try await client
                .from("profiles")
                .update(["avatar_url": publicURL.absoluteString])
                .eq("id", value: user.id)
                .execute()

            avatarURL = publicURL

        } catch {
            alertManager.showAlert(
                title: "Image Upload Failed",
                message: error.localizedDescription
            )
        }
    }
}
