//
//  QuoteCardView.swift
//  QuoteVault
//
//  Created by Nazmin Parween on 14/01/26.
//

import SwiftUI

struct QuoteCardView: View {
    let quote: Quote
    let isFavourite : Bool
    let onFavorite: () -> Void
    let onShare: () -> Void
    @EnvironmentObject var settings: AppSettings

    var body: some View {
        VStack(spacing: 20) {

            Text("“\(quote.text)”")
                .font(.system(size: settings.fontSize, weight: .regular))
                .foregroundStyle(.primary)                 // ✅ dark mode safe
                .multilineTextAlignment(.center)
                .lineLimit(nil)                            // ✅ no limit
                .fixedSize(horizontal: false, vertical: true)
                .padding(.top, 24)

            Text("– \(quote.author)")
                .font(.system(size: settings.fontSize - 2, weight: .semibold))
                .foregroundStyle(.secondary)

            HStack(spacing: 40) {
                Button(action: onFavorite) {
                    Image(systemName: isFavourite ? "heart.fill" : "heart")
                        .font(.title2)
                        .foregroundStyle(.red)             // semantic
                }

                ShareLink(
                    item: "“\(quote.text)” — \(quote.author)",
                    subject: Text("Quote from QuoteVault")
                ) {
                    Image(systemName: "square.and.arrow.up")
                        .font(.title2)
                }


            }
            .padding(.bottom, 20)
        }
        .frame(maxWidth: .infinity)                         // ✅ full width
        .padding(.horizontal, 20)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color(.secondarySystemBackground))    // ✅ adaptive
        )
        .shadow(color: .black.opacity(0.05), radius: 8)
        .padding(.horizontal, 12)
    }
}


