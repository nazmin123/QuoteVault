//
//  SearchView.swift
//  QuoteVault
//
//  Created by Nazmin Parween on 14/01/26.
//
import SwiftUI
import Combine

struct SearchView: View {

    @StateObject private var viewModel = SearchViewModel()
    @State private var searchText = ""
    @State private var selectedTab: SearchTab = .authors

    var body: some View {
        VStack(spacing: 0) {

            header

            Picker("", selection: $selectedTab) {
                ForEach(SearchTab.allCases, id: \.self) {
                    Text($0.title).tag($0)
                }
            }
            .pickerStyle(.segmented)
            .padding()

            content
        }
        .navigationBarHidden(true)
        .task { await viewModel.loadQuotes() }
        .onChange(of: searchText) { text in
            Task { await viewModel.search(keyword: text) }
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Search")
                .font(.largeTitle.bold())

            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search quotes, authors, tags", text: $searchText)
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(14)
        }
        .padding()
    }

    @ViewBuilder
    private var content: some View {
        switch selectedTab {
        case .authors:
            AuthorsListView(groups: viewModel.quotesByAuthor)
        case .quotes:
            QuotesSearchListView(quotes: viewModel.quotes)
        case .tags:
            TagsListView(groups: viewModel.quotesByCategory)
        }
    }
}
