//
//  AddCollectionSheet.swift
//  QuoteVault
//
//  Created by Nazmin Parween on 16/01/26.
//

import SwiftUI

struct AddCollectionSheet: View {

    @State private var name = ""
    let onAdd: (String) -> Void

    var body: some View {
        NavigationStack {
            Form {
                TextField("Collection name", text: $name)
            }
            .navigationTitle("New Collection")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        onAdd(name)
                    }
                    .disabled(name.isEmpty)
                }

                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        onAdd("")
                    }
                }
            }
        }
    }
}

