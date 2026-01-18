//
//  QuoteNotificationManager.swift
//  QuoteVault
//
//  Created by Nazmin Parween on 15/01/26.
//

import UserNotifications

enum QuoteNotificationManager {

    static let identifier = "daily-quote"

    static func requestPermission() async -> Bool {
        let center = UNUserNotificationCenter.current()
        return await withCheckedContinuation { continuation in
            center.requestAuthorization(options: [.alert, .sound]) { granted, _ in
                continuation.resume(returning: granted)
            }
        }
    }

    static func scheduleDailyQuote(
        at hour: Int,
        minute: Int,
        quote: Quote
    ) {

        let content = UNMutableNotificationContent()
        content.title = "Quote of the Day"
        content.body = "“\(quote.text)” — \(quote.author)"
        content.sound = .default

        var components = DateComponents()
        components.hour = hour
        components.minute = minute

        let trigger = UNCalendarNotificationTrigger(
            dateMatching: components,
            repeats: true
        )

        let request = UNNotificationRequest(
            identifier: identifier,
            content: content,
            trigger: trigger
        )

        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: [identifier])
        center.add(request)
    }

    static func cancelDailyQuote() {
        UNUserNotificationCenter.current()
            .removePendingNotificationRequests(withIdentifiers: [identifier])
    }
}
