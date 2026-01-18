//
//  AppSettings.swift
//  QuoteVault
//
//  Created by Nazmin Parween on 15/01/26.
//
import SwiftUI
import Combine

@MainActor
final class AppSettings: ObservableObject {

    @AppStorage("isDarkMode") var isDarkMode: Bool = false {
        didSet { objectWillChange.send() }
    }

    @AppStorage("fontSize") var fontSize: Double = 16 {
        didSet { objectWillChange.send() }
    }

    @AppStorage("accentColor") var accentColor: String = "blue" {
        didSet { objectWillChange.send() }
    }
    
    // MARK: - Notifications

        @AppStorage("dailyQuoteEnabled") var dailyQuoteEnabled: Bool = false {
            didSet { objectWillChange.send() }
        }
    @AppStorage("notificationHour") var dailyQuoteHour: Int = 9
       @AppStorage("notificationMinute") var dailyQuoteMinute: Int = 0

//        @AppStorage("dailyQuoteHour") var dailyQuoteHour: Int = 9 {
//            didSet { objectWillChange.send() }
//        }
//
//        @AppStorage("dailyQuoteMinute") var dailyQuoteMinute: Int = 0 {
//            didSet { objectWillChange.send() }
//        }

    var notificationTime: Date {
           var components = DateComponents()
           components.hour = dailyQuoteHour
           components.minute = dailyQuoteMinute
           return Calendar.current.date(from: components) ?? Date()
       }

        func updateNotificationTime(_ date: Date) {
            let components = Calendar.current.dateComponents([.hour, .minute], from: date)
            dailyQuoteHour = components.hour ?? 9
            dailyQuoteMinute = components.minute ?? 0
            objectWillChange.send()
        }
}


