//
//  View+If.swift
//  
//
//  Created by Philipp Woessner on 02.03.23.
//

import SwiftUI

extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

extension View {
    @ViewBuilder func `if`<Content: View, Value>(_ optional: Value?, transform: (Self, Value) -> Content) -> some View {
        if let optional {
            transform(self, optional)
        } else {
            self
        }
    }
}
