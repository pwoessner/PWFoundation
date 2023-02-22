//
//  PWFoundationStrings.swift
//  
//
//  Created by Woessner, Philipp on 06.02.23.
//

import Foundation

extension String {
    var moduleLocalized: String {
        NSLocalizedString(self, bundle: Bundle.module, comment: self)
    }
}

public struct PWFoundationStrings {
    public static let errorAlertTitle = "Error.Alert.title".moduleLocalized
    public static let errorAlertMessage = "Error.Alert.message".moduleLocalized
    public static let errorAlertOk = "Error.Alert.ok".moduleLocalized
}
