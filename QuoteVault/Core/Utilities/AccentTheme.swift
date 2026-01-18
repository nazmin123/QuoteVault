//
//  AccentTheme.swift
//  QuoteVault
//
//  Created by Nazmin Parween on 15/01/26.
//

import SwiftUI

enum AccentTheme: String, CaseIterable, Identifiable {
    case blue
    case purple
    case green
    case orange

    var id: String { rawValue }

    var color: Color {
        switch self {
        case .blue: return .blue
        case .purple: return .purple
        case .green: return .green
        case .orange: return .orange
        }
    }

    var title: String {
        rawValue.capitalized
    }
}

