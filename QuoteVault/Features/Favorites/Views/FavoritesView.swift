//
//  Untitled.swift
//  QuoteVault
//
//  Created by Nazmin Parween on 13/01/26.
//
import SwiftUI

struct FavoritesView: View {

    @StateObject private var viewModel = FavoritesViewModel()

    var body: some View {
        Group {
            if viewModel.favorites.isEmpty {
                EmptyStateView(
                    title: "No Favorites",
                    message: "Quotes you like will appear here."
                )
            } else {
                List {
                    ForEach(viewModel.favorites) { quote in
                        FavoritesRowView(quote: quote)
                    }
                }
            }
        }
        .navigationTitle("Favorites")
        .task {
            await viewModel.loadFavorites()
        }
    }
}

