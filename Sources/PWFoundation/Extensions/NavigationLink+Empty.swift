//
//  NavigationLink+Empty.swift
//  
//
//  Created by Philipp Woessner on 02.03.23.
//

import SwiftUI

public extension NavigationLink where Label == EmptyView, Destination == EmptyView {
  static var empty: NavigationLink {
    self.init(destination: EmptyView(), label: { EmptyView() })
  }
}
