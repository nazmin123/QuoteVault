//
//  SupabaseManager.swift
//  QuoteVault
//
//  Created by Nazmin Parween on 14/01/26.
//

import Supabase
import Foundation

final class SupabaseManager {

    static let shared = SupabaseManager()

    let client: SupabaseClient

    private init() {
        print("Supabase URL:", AppConstants.supabaseURL)
        print("Parsed host:", AppConstants.supabaseURL.host ?? "nil")

        client = SupabaseClient(
            supabaseURL: URL(string: "https://iwzkcygmcqppwrolesib.supabase.co")!,
            supabaseKey: AppConstants.supabaseAnonKey
        )
    }
}

