//
//  OverlayButton.swift
//  PWFoundation
//
//  Created by Philipp Woessner on 02.03.23.
//

import SwiftUI

public struct OverlayButton: View {
    private let text: String
    private let image: Image
    private let textColor: Color?
    private let backgroundColor: Color?
    private let action: () -> Void

    public init(
        image: Image,
        text: String,
        textColor: Color? = nil,
        backgroundColor: Color? = nil,
        action: @escaping () -> Void
    ) {
        self.image = image
        self.text = text
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.action = action
    }

    public var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: action) {
                    Label {
                        Text(text)
                            .font(.callout)
                            .fontWeight(.medium)
                            .if(textColor) { text, textColor in
                                text.foregroundColor(textColor)
                            }
                    } icon: {
                        image
                    }
                    .padding(PWSpacing.small)
                }
                .if(backgroundColor, transform: { view, color in
                    view
                        .background(color.opacity(0.5))
                })
                .background(.thinMaterial)
                .clipShape(Capsule())
                .padding()

            }
        }
    }
}

struct OverlayButton_Previews: PreviewProvider {
    static var previews: some View {
        OverlayButton(image: Image(systemName: "doc.viewfinder.fill"), text: "Sample") {}
            .previewLayout(.sizeThatFits)
    }
}
