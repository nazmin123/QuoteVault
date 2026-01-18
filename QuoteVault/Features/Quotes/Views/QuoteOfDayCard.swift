//
//  QuoteOfDayCard.swift
//  QuoteVault
//
//  Created by Nazmin Parween on 14/01/26.
//

import SwiftUI

struct QuoteOfDayCard: View {
    let quote: Quote

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Quote of the Day")
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.white.opacity(0.8))

            Text("“\(quote.text)”")
                .font(.body)
                .fontWeight(.thin)
                .foregroundColor(.white)
                .fixedSize(horizontal: false, vertical: true)

            if !quote.author.isEmpty {
                Text("– \(quote.author)")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.75))
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.indigo,
                    Color.purple.opacity(0.85)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .shadow(color: Color.black.opacity(0.15), radius: 8, x: 0, y: 4)
        .padding(.horizontal)
    }
}


