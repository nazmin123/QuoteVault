//
//  Quote.swift
//  QuoteVault
//
//  Created by Nazmin Parween on 13/01/26.
//
import SwiftUI

struct Quote: Identifiable, Decodable {
let id: UUID
let text: String
let author: String
let category: String
}
