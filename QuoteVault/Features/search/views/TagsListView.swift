//
//  TagsListView.swift
//  QuoteVault
//
//  Created by Nazmin Parween on 15/01/26.
//

import SwiftUI

struct TagsListView: View {

    let groups: [String: [Quote]]
    @State private var selectedTag: SheetSelection?

    var body: some View {
        List(groups.keys.sorted(), id: \.self) { tag in
            Button {
                selectedTag = SheetSelection(value: tag)
            } label: {
                HStack {
                    Text(tag)
                    Spacer()
                    Text("\(groups[tag]?.count ?? 0)")
                        .foregroundColor(.secondary)
                }
            }
        }
        .sheet(item: $selectedTag) { tag in
            QuotesSheetView(
                title: tag.value,
                quotes: groups[tag.value] ?? []
            )
        }
    }
}

