//
//  ViewExtension.swift
//  Thirtys
//
//  Created by Bayu Septyan Nur Hidayat on 19/05/24.
//

import SwiftUI

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
    
    @ViewBuilder func applyTextColor(_ color: Color) -> some View {
      if UITraitCollection.current.userInterfaceStyle == .light {
        self.colorInvert().colorMultiply(color)
      } else {
        self.colorMultiply(color)
      }
    }
}
