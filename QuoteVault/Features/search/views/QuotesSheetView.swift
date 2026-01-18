//
//  QuotesSheetView.swift
//  QuoteVault
//
//  Created by Nazmin Parween on 15/01/26.
//
import SwiftUI

struct QuotesSheetView: View {

    let title: String
    let quotes: [Quote]

    var body: some View {
        NavigationStack {
            List(quotes) { quote in
                VStack(alignment: .leading, spacing: 6) {
                    Text("“\(quote.text)”")
                    Text("– \(quote.author)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

