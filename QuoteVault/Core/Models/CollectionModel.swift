//
//  CollectionModel.swift
//  QuoteVault
//
//  Created by Nazmin Parween on 13/01/26.
//

import SwiftUI

struct CollectionModel: Identifiable, Codable {
    let id: UUID
    let name: String
    let createdAt: Date?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case createdAt = "created_at"
    }
}

struct CollectionInsert: Encodable {
    let name: String
    let user_id: UUID
}
