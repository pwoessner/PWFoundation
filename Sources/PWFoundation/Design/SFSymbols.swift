//
//  SFSymbols.swift
//  
//
//  Created by Woessner, Philipp on 23.03.23.
//

import Foundation
import SwiftUI

public enum SFSymbol: String {
    case person = "person"
    case docViewFinder = "doc.viewfinder"
    case docText = "doc.text"
    case suareAndArrowUp = "square.and.arrow.up"
    case textQuote = "text.quote"
    case calendarBadgeClock = "calendar.badge.clock"
    case docOnDoc = "doc.on.doc"
    case externalDrive = "externaldrive"
    case listBullet = "list.bullet"
    case checkmark = "checkmark"
    case gearshape = "gearshape"
    case listBulletRectanglePortrait = "list.bullet.rectangle.portrait"
    case flag = "flag"
    case line3HorizontalDecrease = "line.3.horizontal.decrease"
    case plus = "plus"
    case listBulletClipboard = "list.bullet.clipboard"

    public static func image(for symbol: SFSymbol) -> Image {
        Image(systemName: symbol.rawValue)
    }

    public static func image(for systemName: String) -> Image {
        Image(systemName: systemName)
    }

    public var crop: String { self.rawValue + ".crop" }
    public var circle: String { self.rawValue + ".circle" }
    public var fill: String { self.rawValue + ".fill" }

}
