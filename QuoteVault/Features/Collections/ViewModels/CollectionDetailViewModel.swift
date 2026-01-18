//
//  CollectionDetailViewModel.swift
//  QuoteVault
//
//  Created by Nazmin Parween on 13/01/26.
//
import SwiftUI
import Combine
import Supabase

@MainActor
final class CollectionDetailViewModel: ObservableObject {

    // MARK: - UI State
    @Published var quotes: [Quote] = []
    @Published var isLoading = false

    // MARK: - Dependencies
    private let client = SupabaseManager.shared.client
    let collectionId: UUID

    // MARK: - Init
    init(collectionId: UUID) {
        self.collectionId = collectionId
    }

    // MARK: - Load Quotes in Collection
    func loadQuotes() async {
        isLoading = true
        defer { isLoading = false }

        do {
            struct Response: Decodable {
                let quote: Quote
            }

            let response: [Response] = try await client
                .from("collection_quotes")
                .select("""
                    quote:quotes (
                        id,
                        text,
                        author,
                        category
                    )
                """)
                .eq("collection_id", value: collectionId.uuidString)
                .execute()
                .value

            quotes = response.map { $0.quote }

        } catch {
            AppAlertManager.shared.showAlert(
                title: "Failed to Load Quotes",
                message: error.localizedDescription
            )
        }
    }

    // MARK: - Add Quote to Collection
    func addQuote(_ quote: Quote) async {
        do {
            guard let userId = client.auth.currentUser?.id.uuidString else {
                AppAlertManager.shared.showAlert(
                    title: "Authentication Error",
                    message: "You must be logged in to add quotes."
                )
                return
            }

            try await client
                .from("collection_quotes")
                .insert([
                    "collection_id": collectionId.uuidString,
                    "quote_id": quote.id.uuidString,
                    "user_id": userId
                ])
                .execute()

            await loadQuotes()

        } catch {
            AppAlertManager.shared.showAlert(
                title: "Add Quote Failed",
                message: error.localizedDescription
            )
        }
    }

    // MARK: - Remove Quote from Collection
    func removeQuote(_ quote: Quote) async {
        do {
            try await client
                .from("collection_quotes")
                .delete()
                .eq("collection_id", value: collectionId.uuidString)
                .eq("quote_id", value: quote.id.uuidString)
                .execute()

            quotes.removeAll { $0.id == quote.id }

        } catch {
            AppAlertManager.shared.showAlert(
                title: "Remove Quote Failed",
                message: "Unable to remove the quote. Please try again."
            )
        }
    }
}
