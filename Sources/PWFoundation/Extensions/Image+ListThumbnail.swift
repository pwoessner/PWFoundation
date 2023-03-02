//
//  Thumbnail.swift
//  
//
//  Created by Woessner, Philipp on 21.02.23.
//

import SwiftUI

public extension Image {
    func listThumbnail(
        maxWidth: CGFloat = PWSpacing.listThumbnail
    ) -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: maxWidth)
            .clipShape(RoundedRectangle(cornerRadius: PWSpacing.micro))
            .padding(PWSpacing.minor)
    }
}
