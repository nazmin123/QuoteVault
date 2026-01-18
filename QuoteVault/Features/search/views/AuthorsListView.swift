//
//  AuthorsListView.swift
//  QuoteVault
//
//  Created by Nazmin Parween on 15/01/26.
//
import SwiftUI

struct AuthorsListView: View {

    let groups: [String: [Quote]]
    @State private var selectedAuthor: SheetSelection?

    var body: some View {
        List(groups.keys.sorted(), id: \.self) { author in
            Button {
                selectedAuthor = SheetSelection(value: author)
            } label: {
                HStack {
                    Circle().frame(width: 44, height: 44)
                    VStack(alignment: .leading) {
                        Text(author)
                        Text("\(groups[author]?.count ?? 0) Quotes")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                }
            }
        }
        .sheet(item: $selectedAuthor) { author in
            QuotesSheetView(
                title: author.value,
                quotes: groups[author.value] ?? []
            )
        }
    }
}

