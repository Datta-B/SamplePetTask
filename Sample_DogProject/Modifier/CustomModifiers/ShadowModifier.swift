//
//  ShadowModifier.swift
//  Sample_DogProject
//
//  Created by dattaz biradar on 17/03/26.
//

import SwiftUI

struct customShadowModifer : ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: .black.opacity(0.05), radius: 8)
    }
}

extension View {
    func customShadow() -> some View {
        self.modifier(customShadowModifer())
    }
}
