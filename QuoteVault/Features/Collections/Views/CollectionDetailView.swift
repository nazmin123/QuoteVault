//
//  CollectionDetailView.swift
//  QuoteVault
//
//  Created by Nazmin Parween on 13/01/26.
//

import SwiftUI

struct CollectionDetailView: View {

    let collection: CollectionModel
    @StateObject private var viewModel: CollectionDetailViewModel
    @State private var showAddQuoteSheet = false

    init(collection: CollectionModel) {
        self.collection = collection
        _viewModel = StateObject(
            wrappedValue: CollectionDetailViewModel(
                collectionId: collection.id
            )
        )
    }

    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView()
            } else if viewModel.quotes.isEmpty {
                EmptyStateView(
                    title: "No Quotes",
                    message: "Add quotes to this collection"
                )
            } else {
                List {
                    ForEach(viewModel.quotes) { quote in
                        FavoritesRowView(quote: quote)
                    }
                    .onDelete { indexSet in
                        for index in indexSet {
                            let quote = viewModel.quotes[index]
                            Task {
                                await viewModel.removeQuote(quote)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle(collection.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showAddQuoteSheet = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showAddQuoteSheet) {
            AddQuoteSheet { quote in
                Task {
                    await viewModel.addQuote(quote)
                }
            }
        }
        .task {
            await viewModel.loadQuotes()
        }
    }
}


