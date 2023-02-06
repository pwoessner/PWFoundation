//
//  View+Alert.swift
//  
//
//  Created by Woessner, Philipp on 06.02.23.
//

import Foundation
import SwiftUI

public extension View {
    func errorAlert(error: Binding<Error?>, action: (() -> Void)? = nil) -> some View {
        alert(
            AlertDetails.errorAlertDetails.title,
            isPresented: .constant(error.wrappedValue != nil),
            presenting: AlertDetails.errorAlertDetails
        ) { details in
            Button(AlertDetails.errorAlertDetails.primaryButtonText) {
                error.wrappedValue = nil
            }

            if let secondaryButtonText = AlertDetails.errorAlertDetails.secondaryButtonText, let action {
                Button(secondaryButtonText, action: action)
            }
        } message: { details in
            if let message = details.message {
                Text(message)
            }
        }
    }

    func errorAlert(details: Binding<AlertDetails?>, action: (() -> Void)? = nil) -> some View {
        alert(
            details.wrappedValue?.title ?? AlertDetails.errorAlertDetails.title,
            isPresented: .constant(details.wrappedValue != nil),
            presenting: details
        ) { details in
            Button(details.wrappedValue?.primaryButtonText ?? AlertDetails.errorAlertDetails.primaryButtonText) {
                details.wrappedValue = nil
            }

            if let secondaryButtonText = details.wrappedValue?.secondaryButtonText, let action {
                Button(secondaryButtonText, action: action)
            }
        } message: { details in
            if let message = details.wrappedValue?.message {
                Text(message)
            }
        }
    }
}

public struct AlertDetails {
    let title: String
    let message: String?
    let primaryButtonText: String
    let secondaryButtonText: String?

    static let errorAlertDetails = AlertDetails(
        title: PWFoundationStrings.errorAlertTitle,
        message: PWFoundationStrings.errorAlertMessage,
        primaryButtonText: PWFoundationStrings.errorAlertOk
    )

    init(title: String,
         message: String?,
         primaryButtonText: String,
         secondaryButtonText: String? = nil
    ) {
        self.title = title
        self.message = message
        self.primaryButtonText = primaryButtonText
        self.secondaryButtonText = secondaryButtonText
    }
}
