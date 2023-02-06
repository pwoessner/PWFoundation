//
//  PWKeychainItem.swift
//  iPhone
//
//  Created by Woessner, Philipp on 13.06.20.
//  Copyright © 2020 Woessner. All rights reserved.
//

import Foundation

enum PWKeychainError: Error {
	case noPassword
	case unexpectedPasswordData
	case unexpectedItemData
	case unhandledError
}

public struct PWKeychainItem {

    // MARK: Properties
    let service: String

    private(set) var account: String

    let accessGroup: String?

    // MARK: Intialization

    init(service: String, account: String, accessGroup: String? = nil) {
        self.service = service
        self.account = account
        self.accessGroup = accessGroup
    }

    // MARK: Keychain access

    func readItem() throws -> String {
        /*
         Build a query to find the item that matches the service, account and
         access group.
         */
        var query = PWKeychainItem.keychainQuery(withService: service, account: account, accessGroup: accessGroup)
        query[kSecMatchLimit as String] = kSecMatchLimitOne
        query[kSecReturnAttributes as String] = kCFBooleanTrue
        query[kSecReturnData as String] = kCFBooleanTrue

        // Try to fetch the existing keychain item that matches the query.
        var queryResult: AnyObject?
        let status = withUnsafeMutablePointer(to: &queryResult) {
            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }

        // Check the return status and throw an error if appropriate.
        guard status != errSecItemNotFound else { throw PWKeychainError.noPassword }
        guard status == noErr else { throw PWKeychainError.unhandledError }

        // Parse the password string from the query result.
        guard let existingItem = queryResult as? [String: AnyObject],
            let passwordData = existingItem[kSecValueData as String] as? Data,
            let password = String(data: passwordData, encoding: String.Encoding.utf8)
            else {
                throw PWKeychainError.unexpectedPasswordData
        }

        return password
    }

    func saveItem(_ password: String) throws {
        // Encode the password into an Data object.
        guard let encodedPassword = password.data(using: String.Encoding.utf8) else {
            throw PWKeychainError.noPassword
        }

        do {
            // Check for an existing item in the keychain.
            try _ = readItem()

            // Update the existing item with the new password.
            var attributesToUpdate = [String: AnyObject]()
            attributesToUpdate[kSecValueData as String] = encodedPassword as AnyObject?

            let query = PWKeychainItem.keychainQuery(withService: service, account: account, accessGroup: accessGroup)
            let status = SecItemUpdate(query as CFDictionary, attributesToUpdate as CFDictionary)

            // Throw an error if an unexpected status was returned.
            guard status == noErr else { throw PWKeychainError.unhandledError }
        } catch PWKeychainError.noPassword {
            /*
             No password was found in the keychain. Create a dictionary to save
             as a new keychain item.
             */
            var newItem = PWKeychainItem.keychainQuery(withService: service, account: account, accessGroup: accessGroup)
            newItem[kSecValueData as String] = encodedPassword as AnyObject?

            // Add a the new item to the keychain.
            let status = SecItemAdd(newItem as CFDictionary, nil)

            // Throw an error if an unexpected status was returned.
            guard status == noErr else { throw PWKeychainError.unhandledError }
        }
    }

    func deleteItem() throws {
        // Delete the existing item from the keychain.
        let query = PWKeychainItem.keychainQuery(withService: service, account: account, accessGroup: accessGroup)
        let status = SecItemDelete(query as CFDictionary)

        // Throw an error if an unexpected status was returned.
        guard status == noErr || status == errSecItemNotFound else { throw PWKeychainError.unhandledError }
    }

    // MARK: Convenience

    private static func keychainQuery(withService service: String, account: String? = nil, accessGroup: String? = nil) -> [String: AnyObject] {
        var query = [String: AnyObject]()
        query[kSecClass as String] = kSecClassGenericPassword
        query[kSecAttrService as String] = service as AnyObject?

        if let account = account {
            query[kSecAttrAccount as String] = account as AnyObject?
        }

        if let accessGroup = accessGroup {
            query[kSecAttrAccessGroup as String] = accessGroup as AnyObject?
        }

        return query
    }
}
