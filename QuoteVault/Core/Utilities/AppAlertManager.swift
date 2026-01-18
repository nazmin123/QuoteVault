//
//  AppAlertManager.swift
//  QuoteVault
//
//  Created by Nazmin Parween on 17/01/26.
//

import SwiftUI
import Combine

/// A central alert manager for showing app-wide alerts
final class AppAlertManager: ObservableObject {

    static let shared = AppAlertManager()

    @Published var alertData: AlertData?

    init() {}

    func showAlert(
            title: String = "Error",
            message: String,
            primaryButton: Alert.Button = .default(Text("OK")),
            secondaryButton: Alert.Button? = nil
        ) {
            DispatchQueue.main.async {
                self.alertData = AlertData(
                    title: title,
                    message: message,
                    primaryButton: primaryButton,
                    secondaryButton: secondaryButton
                )
            }
        }

    struct AlertData: Identifiable {
        let id = UUID()
        let title: String
        let message: String
        let primaryButton: Alert.Button
        let secondaryButton: Alert.Button?
    }

}

