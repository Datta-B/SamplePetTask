//
//  FontModifier.swift
//  Sample_DogProject
//
//  Created by dattaz biradar on 25/03/26.
//

import Foundation
import SwiftUI

struct FontStyleModifier: ViewModifier {
    let size: CGFloat
    let weight: Font.Weight?
    let color: Color?
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: size, weight: weight ?? .medium))
            .foregroundStyle(color ?? .appPrimary)
    }
}

extension View {
    func fontStyle(
        size: CGFloat,
        weight: Font.Weight? = nil,
        color: Color? = nil
    ) -> some View {
        self.modifier(FontStyleModifier(size: size, weight: weight, color: color))
    }
}
