//
//  UndimmedSheet.swift
//  PWFoundation
//
//  Created by Woessner, Philipp on 28.02.23.
//

import SwiftUI
import UIKit

@available(iOS 16.0, *)
public enum UndimmedPresentationDetent {
    case large
    case medium
    case fraction(_ value: CGFloat)
    case height(_ value: CGFloat)

    var swiftUIDetent: PresentationDetent {
        switch self {
        case .large: return .large
        case .medium: return .medium
        case .fraction(let value): return .fraction(value)
        case .height(let value): return .height(value)
        }
    }

    var uiKitIdentifier: UISheetPresentationController.Detent.Identifier {
        switch self {
        case .large: return .large
        case .medium: return .medium
        case let .fraction(value): return .fraction(value)
        case let .height(value): return .height(value)
        }
    }
}

@available(iOS 16.0, *)
extension Collection where Element == UndimmedPresentationDetent {
    var swiftUISet: Set<PresentationDetent> {
        Set(map { $0.swiftUIDetent })
    }
}

@available(iOS 16.0, *)
public struct UndimmedPresentationDetentsViewModifier: ViewModifier {
    init(
        undimmedDetents: [UndimmedPresentationDetent],
        largestUndimmed: UndimmedPresentationDetent? = nil
    ) {
        self.undimmedDetents = undimmedDetents
        self.largestUndimmed = largestUndimmed
        self.selection = nil
    }

    init(
        undimmedDetents: [UndimmedPresentationDetent],
        largestUndimmed: UndimmedPresentationDetent? = nil,
        selection: Binding<PresentationDetent>
    ) {
        self.undimmedDetents = undimmedDetents
        self.largestUndimmed = largestUndimmed
        self.selection = selection
    }

    private let undimmedDetents: [UndimmedPresentationDetent]
    private let largestUndimmed: UndimmedPresentationDetent?
    private let selection: Binding<PresentationDetent>?

    public func body(content: Content) -> some View {
        if let selection = selection {
            content
                .background(background)
                .presentationDetents(
                    Set(undimmedDetents.swiftUISet),
                    selection: selection)
        } else {
            content
                .background(background)
                .presentationDetents(undimmedDetents.swiftUISet)
        }
    }
}

@available(iOS 16.0, *)
private extension UndimmedPresentationDetentsViewModifier {
    var background: some View {
        UndimmedDetentView(
            largestUndimmed: largestUndimmed ?? undimmedDetents.last
        )
    }
}

@available(iOS 16.0, *)
public extension View {
    func presentationDetents(
        undimmed detents: [UndimmedPresentationDetent],
        largestUndimmed: UndimmedPresentationDetent? = nil
    ) -> some View {
        self.modifier(
            UndimmedPresentationDetentsViewModifier(
                undimmedDetents: detents,
                largestUndimmed: largestUndimmed
            )
        )
    }

    func presentationDetents(
        undimmed detents: [UndimmedPresentationDetent],
        largestUndimmed: UndimmedPresentationDetent? = nil,
        selection: Binding<PresentationDetent>
    ) -> some View {
        self.modifier(
            UndimmedPresentationDetentsViewModifier(
                undimmedDetents: detents,
                largestUndimmed: largestUndimmed,
                selection: selection
            )
        )
    }
}

@available(iOS 16.0, *)
private struct UndimmedDetentView: UIViewControllerRepresentable {
    var largestUndimmed: UndimmedPresentationDetent?

    func makeUIViewController(context: Context) -> UIViewController {
        let result = UndimmedDetentController()
        result.largestUndimmedDetent = largestUndimmed
        return result
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

@available(iOS 16.0, *)
private class UndimmedDetentController: UIViewController {
    var largestUndimmedDetent: UndimmedPresentationDetent?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        avoidDimmingParent()
        avoidDisablingControls()

        sheetPresentationController?.prefersGrabberVisible = true
    }

    func avoidDimmingParent() {
        let id = largestUndimmedDetent?.uiKitIdentifier
        sheetPresentationController?.largestUndimmedDetentIdentifier = id
    }

    func avoidDisablingControls() {
        presentingViewController?.view.tintAdjustmentMode = .normal
    }
}

extension UISheetPresentationController.Detent.Identifier {
    static func fraction(_ value: CGFloat) -> Self {
        .init("Fraction:\(String(format: "%.1f", value))")
    }

    static func height(_ value: CGFloat) -> Self {
        .init("Height:\(value)")
    }
}
