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

struct PWFoundationStrings {
    static let errorAlertTitle = "Error.Alert.title".moduleLocalized
    static let errorAlertMessage = "Error.Alert.message".moduleLocalized
    static let errorAlertOk = "Error.Alert.ok".moduleLocalized
}
