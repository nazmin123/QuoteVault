//
//  AppConstants.swift
//  QuoteVault
//
//  Created by Nazmin Parween on 14/01/26.
//

import Foundation

enum AppConstants {

    static let supabaseURL: URL = {
        guard
            let value = Bundle.main.infoDictionary?["SUPABASE_URL"] as? String,
            let url = URL(string: value)
        else {
            fatalError("SUPABASE_URL missing in Info.plist")
        }
        return url
    }()

    static let supabaseAnonKey: String = {
        guard
            let key = Bundle.main.infoDictionary?["SUPABASE_ANON_KEY"] as? String
        else {
            fatalError("SUPABASE_ANON_KEY missing in Info.plist")
        }
        return key
    }()
}

