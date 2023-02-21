//
//  File.swift
//  
//
//  Created by Woessner, Philipp on 21.02.23.
//

import SwiftUI

public extension Image {
    init?(data: Data?) {
        guard let data, let uiImage = UIImage(data: data) else { return nil }
        self = Image(uiImage: uiImage)
    }
}
