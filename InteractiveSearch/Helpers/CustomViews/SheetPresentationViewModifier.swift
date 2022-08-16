//
//  SheetPresentationViewModifier.swift
//  InteractiveSearch
//
//  Created by Ehsan Askari on 8/16/22.
//

import SwiftUI

struct SheetPresentationViewModifier<SwiftUIContent>: ViewModifier where SwiftUIContent: View {
    
    @Binding var isPresented: Bool
    let onDismiss: (() -> Void)?
    let detents: [UISheetPresentationController.Detent]
    let swiftUIContent: SwiftUIContent
    
    init(isPresented: Binding<Bool>, detents: [UISheetPresentationController.Detent] = [.medium()] , onDismiss: (() -> Void)? = nil, content: () -> SwiftUIContent) {
        self._isPresented = isPresented
        self.onDismiss = onDismiss
        self.swiftUIContent = content()
        self.detents = detents
    }
    
    func body(content: Content) -> some View {
        ZStack {
            SheetPresentationView($isPresented, onDismiss: onDismiss, detents: detents) {
                swiftUIContent
            }.fixedSize()
            content
        }
    }
}
