//
//  Thumbnail.swift
//  
//
//  Created by Woessner, Philipp on 21.02.23.
//

import SwiftUI

public extension Image {
    func listThumbnail() -> some View {
        self
            .resizable()
            .frame(width: PWSpacing.listThumbnail, height: PWSpacing.listThumbnail)
            .clipShape(RoundedRectangle(cornerRadius: PWSpacing.minor))
    }
}
