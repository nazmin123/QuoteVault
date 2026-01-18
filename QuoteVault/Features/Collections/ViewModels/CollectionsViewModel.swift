//
//  CollectionsViewModel.swift
//  QuoteVault
//
//  Created by Nazmin Parween on 13/01/26.
//

import SwiftUI
import Combine
import Supabase
import Foundation

@MainActor
final class CollectionsViewModel: ObservableObject {

    @Published var collections: [CollectionModel] = []
    @Published var isLoading = false

    private let client = SupabaseManager.shared.client

    // MARK: - Load Collections

    func loadCollections() async {
        isLoading = true
        defer { isLoading = false }

        do {
            let user = try await client.auth.user()

            collections = try await client
                .from("collections")
                .select()
                .eq("user_id", value: user.id)
                .order("created_at")
                .execute()
                .value

        } catch {
            AppAlertManager.shared.showAlert(
                title: "Failed to Load Collections",
                message: error.localizedDescription
            )
        }
    }

    // MARK: - Add Collection

    func addCollection(name: String) async {
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty else {
            AppAlertManager.shared.showAlert(
                title: "Invalid Name",
                message: "Collection name cannot be empty."
            )
            return
        }

        do {
            let user = try await client.auth.user()

            let payload = CollectionInsert(
                name: name,
                user_id: user.id
            )

            try await client
                .from("collections")
                .insert(payload)
                .execute()

            await loadCollections()

        } catch {
            AppAlertManager.shared.showAlert(
                title: "Unable to Add Collection",
                message: error.localizedDescription
            )
        }
    }

    // MARK: - Delete Collection

    func deleteCollection(_ collection: CollectionModel) async {
        do {
            try await client
                .from("collections")
                .delete()
                .eq("id", value: collection.id)
                .execute()

            collections.removeAll { $0.id == collection.id }

        } catch {
            AppAlertManager.shared.showAlert(
                title: "Delete Failed",
                message: "Could not delete the collection. Please try again."
            )
        }
    }
}

