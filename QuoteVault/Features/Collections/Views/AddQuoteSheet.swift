//
//  AddQuoteSheet.swift
//  QuoteVault
//
//  Created by Nazmin Parween on 16/01/26.
//

import SwiftUI
import Supabase

struct AddQuoteSheet: View {

    let onSelect: (Quote) -> Void
    @Environment(\.dismiss) private var dismiss

    @State private var quotes: [Quote] = []
    @State private var isLoading = false

    private let client = SupabaseManager.shared.client

    var body: some View {
        NavigationView {
            Group {
                if isLoading {
                    ProgressView()
                } else {
                    List(quotes) { quote in
                        Button {
                            onSelect(quote)
                            dismiss()
                        } label: {
                            VStack(alignment: .leading) {
                                Text(quote.text)
                                Text(quote.author)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Add Quote")
            .task {
                await loadQuotes()
            }
        }
    }

    private func loadQuotes() async {
        isLoading = true
        defer { isLoading = false }

        do {
            quotes = try await client
                .from("quotes")
                .select("id, text, author, category")
                .limit(100)
                .execute()
                .value
        } catch {
            AppAlertManager.shared.showAlert(
                title: "Error",
                message: "Unable to load Quotes. Please try again."
            )
        }
    }
}

