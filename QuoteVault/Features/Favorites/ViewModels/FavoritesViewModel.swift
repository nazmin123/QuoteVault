//
//  FavoritesViewModel.swift
//  QuoteVault
//
//  Created by Nazmin Parween on 13/01/26.
//

import SwiftUI
import Combine
import Supabase

@MainActor
final class FavoritesViewModel: ObservableObject {

    @Published var favorites: [Quote] = []
    @Published var isLoading = false

    private let client = SupabaseManager.shared.client
    private let alertManager = AppAlertManager.shared
    

    func loadFavorites() async {
        isLoading = true
        defer { isLoading = false }

        do {
            let response: [FavoriteQuote] = try await client
                .from("favorites")
                .select("""
                    id,
                    quote:quotes(*)
                """)
                .execute()
                .value

            favorites = response.map { $0.quote }

        } catch {
            print("Load favorites error:", error)
            alertManager.showAlert(
                           title: "Failed to Load Favorites",
                           message: error.localizedDescription
                       )
        }
    }

    func toggleFavorite(_ quote: Quote) async {
        guard let userId = client.auth.currentUser?.id else {
            alertManager.showAlert(
                         title: "Session Expired",
                         message: "Please sign in again to manage favorites."
                     )
            return
        }

        if favorites.contains(where: { $0.id == quote.id }) {
            await removeFavorite(quoteId: quote.id)
        } else {
            await addFavorite(userId: userId, quoteId: quote.id)
        }
    }

    private func addFavorite(userId: UUID, quoteId: UUID) async {
        do {
            try await client
                .from("favorites")
                .insert([
                    "user_id": userId.uuidString,
                    "quote_id": quoteId.uuidString
                ])
                .execute()

            await loadFavorites()
        } catch {
            print("Add favorite error:", error)
            alertManager.showAlert(
                          title: "Unable to Add Favorite",
                          message: error.localizedDescription
                      )
        }
    }

    private func removeFavorite(quoteId: UUID) async {
        do {
            try await client
                .from("favorites")
                .delete()
                .eq("quote_id", value: quoteId.uuidString)
                .execute()

            favorites.removeAll { $0.id == quoteId }
        } catch {
            print("Remove favorite error:", error)
            alertManager.showAlert(
                         title: "Unable to Remove Favorite",
                         message: error.localizedDescription,
                         primaryButton: .destructive(Text("OK"))
                     )
        }
    }
}

extension FavoritesViewModel {
    func isFavorite(_ quote: Quote) -> Bool {
        favorites.contains { $0.id == quote.id }
    }
}

