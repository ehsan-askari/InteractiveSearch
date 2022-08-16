//
//  ViewExtension.swift
//  InteractiveSearch
//
//  Created by Ehsan Askari on 8/16/22.
//

import SwiftUI

extension View {
    
    func sheetWithDetents<Content>(isPresented: Binding<Bool>, detents: [UISheetPresentationController.Detent], onDismiss: (() -> Void)?, content: @escaping () -> Content) -> some View where Content : View {
        modifier(
            SheetPresentationViewModifier(isPresented: isPresented, detents: detents, onDismiss: onDismiss, content: content)
        )
    }
}
