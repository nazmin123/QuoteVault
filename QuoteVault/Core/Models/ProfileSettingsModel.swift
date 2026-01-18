//
//  Profile.swift
//  QuoteVault
//
//  Created by Nazmin Parween on 14/01/26.
//

import Foundation

struct Profile: Decodable {
    let id: UUID
    let name: String?
    let settings: UserSettings?
    let avatar_url : String?
}

struct UserSettings: Codable {
    let darkMode: Bool
    let fontSize: Double
    let accentColor: String
}

