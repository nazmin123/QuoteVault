//
//  FavoriteQuote.swift
//  QuoteVault
//
//  Created by Nazmin Parween on 15/01/26.
//

import Foundation

struct FavoriteQuote: Decodable, Identifiable {
    let id: UUID
    let quote: Quote
}
