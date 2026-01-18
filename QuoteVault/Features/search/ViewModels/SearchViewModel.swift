//
//  SearchViewModel.swift
//  QuoteVault
//
//  Created by Nazmin Parween on 15/01/26.
//

import SwiftUI
import Supabase
import Combine

@MainActor
final class SearchViewModel: ObservableObject {

    @Published var quotes: [Quote] = []
    @Published var isLoading = false

    private let client = SupabaseManager.shared.client
    private let alertManager = AppAlertManager.shared

    // MARK: - Fetch All Quotes (Initial Load)

    func loadQuotes() async {
        isLoading = true
        defer { isLoading = false }

        do {
            quotes = try await client
                .from("quotes")
                .select()
                .order("author", ascending: true)
                .execute()
                .value
        } catch {
            alertManager.showAlert(
                title: "Unable to Load Quotes",
                message: error.localizedDescription
            )
        }
    }

    // MARK: - Search (Text / Author / Category)

    func search(keyword: String) async {
        guard !keyword.isEmpty else {
            await loadQuotes()
            return
        }

        isLoading = true
        defer { isLoading = false }

        do {
            quotes = try await client
                .from("quotes")
                .select()
                .or(
                    "text.ilike.%\(keyword)%,author.ilike.%\(keyword)%,category.ilike.%\(keyword)%"
                )
                .execute()
                .value
        } catch {
            alertManager.showAlert(
                title: "Search Failed",
                message: error.localizedDescription
            )
        }
    }

    // MARK: - Grouping Helpers

    var quotesByAuthor: [String: [Quote]] {
        Dictionary(grouping: quotes, by: { $0.author })
    }

    var quotesByCategory: [String: [Quote]] {
        Dictionary(grouping: quotes, by: { $0.category })
    }
}


