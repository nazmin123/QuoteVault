//
//  CollectionsView.swift
//  QuoteVault
//
//  Created by Nazmin Parween on 13/01/26.
//
import SwiftUI

struct CollectionsView: View {

    @StateObject private var viewModel = CollectionsViewModel()
    @State private var showAddSheet = false

    var body: some View {
        List {
            ForEach(viewModel.collections) { collection in
                NavigationLink {
                    CollectionDetailView(collection: collection)
                } label: {
                    Text(collection.name)
                }
            }
            .onDelete { indexSet in
                for index in indexSet {
                    let collection = viewModel.collections[index]
                    Task {
                        await viewModel.deleteCollection(collection)
                    }
                }
            }
        }
        .navigationTitle("Collections")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showAddSheet = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showAddSheet) {
            AddCollectionSheet { name in
                showAddSheet = false
                if !name.isEmpty {
                    Task {
                        await viewModel.addCollection(name: name)
                    }
                }
            }
        }
        .task {
            await viewModel.loadCollections()
        }
    }
}

