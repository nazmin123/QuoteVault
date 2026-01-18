//
//   EmptyStateView.swift
//  QuoteVault
//
//  Created by Nazmin Parween on 14/01/26.
//

import SwiftUI

struct EmptyStateView: View {

    let title: String
    let message: String
    let systemImage: String

    init(
        title: String = "No Quotes Available",
        message: String = "Pull down to refresh or try again later.",
        systemImage: String = "quote.bubble"
    ) {
        self.title = title
        self.message = message
        self.systemImage = systemImage
    }

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: systemImage)
                .font(.system(size: 42))
                .foregroundStyle(.secondary)

            Text(title)
                .font(.headline)

            Text(message)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
        }
        .padding(.top, 48)
        .frame(maxWidth: .infinity)
    }
}
