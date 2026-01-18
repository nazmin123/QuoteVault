//
//  SearchTab.swift
//  QuoteVault
//
//  Created by Nazmin Parween on 15/01/26.
//
import SwiftUI

enum SearchTab: CaseIterable {
    case authors, quotes, tags
    var title: String {
        switch self {
        case .authors: return "Authors"
        case .quotes: return "Quotes"
        case .tags: return "Tags"
        }
    }
}
