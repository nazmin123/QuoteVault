//
//  QuotesSearchListView.swift
//  QuoteVault
//
//  Created by Nazmin Parween on 15/01/26.
//
import SwiftUI

struct QuotesSearchListView: View {

    let quotes: [Quote]

    var body: some View {
        List(quotes) { quote in
            VStack(alignment: .leading, spacing: 6) {
                Text("“\(quote.text)”")
                Text("– \(quote.author)")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(quote.category)
                    .font(.caption2)
                    .foregroundColor(.blue)
            }
        }
    }
}

