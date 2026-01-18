//
//  HomeViewModel.swift
//  QuoteVault
//
//  Created by Nazmin Parween on 13/01/26.
//
import SwiftUI
import Combine
import Foundation
import Supabase

@MainActor
final class HomeViewModel: ObservableObject {

    @Published var quotes: [Quote] = []
    @Published var isLoading = false
   // @Published var errorMessage: String?
    @Published var quoteOfTheDay: Quote = .defaultQuote

    private let client = SupabaseManager.shared.client
    private let settings = AppSettings()
    private let alertManager = AppAlertManager.shared

    // Pagination
    private let pageSize = 20
    private var currentOffset = 0
    private var hasMoreData = true
    private var isFetchingNextPage = false

    // MARK: - Initial Load

    func loadInitialQuotes() async {
        guard quotes.isEmpty else { return }
        resetPagination()
        await fetchNextPage()
    }

    // MARK: - Pull to Refresh

    func refresh() async {
        resetPagination()
        await fetchNextPage()
    }

    private func resetPagination() {
        quotes.removeAll()
        currentOffset = 0
        hasMoreData = true
    }

    // MARK: - Infinite Scroll Trigger

    func loadMoreIfNeeded(currentQuote quote: Quote) async {
        guard let last = quotes.last else { return }
        guard last.id == quote.id else { return }

        await fetchNextPage()
    }

    // MARK: - Fetch Quotes (Paged)

    private func fetchNextPage() async {
        guard !isFetchingNextPage, hasMoreData else { return }

        isFetchingNextPage = true
        isLoading = currentOffset == 0
        

        do {
            let result: [Quote] = try await client
                .from("quotes")
                .select()
                .order("created_at", ascending: false)
                .range(
                    from: currentOffset,
                    to: currentOffset + pageSize - 1
                )
                .execute()
                .value

            quotes.append(contentsOf: result)
            currentOffset += result.count
            hasMoreData = result.count == pageSize

            if currentOffset == result.count, let random = result.randomElement() {
                quoteOfTheDay = random
                scheduleNotificationIfNeeded(with: random)
            }

        } catch {
            alertManager.showAlert(
                           title: "Unable to Load Quotes",
                           message: error.localizedDescription
                       )
        }

        isFetchingNextPage = false
        isLoading = false
    }

    private func scheduleNotificationIfNeeded(with quote: Quote) {
        guard settings.dailyQuoteEnabled else { return }

        QuoteNotificationManager.scheduleDailyQuote(
            at: settings.dailyQuoteHour,
            minute: settings.dailyQuoteMinute,
            quote: quote
        )
    }
}


extension Quote {
    static let defaultQuote = Quote(
        id: UUID(),
        text: "Small progress each day adds up to big results.",
        author: "unknown",
        category: "Motivation"
    )
}

