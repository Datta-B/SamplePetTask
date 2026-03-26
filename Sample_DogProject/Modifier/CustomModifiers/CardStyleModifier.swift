//
//  CardStyleModifier.swift
//  Sample_DogProject
//
//  Created by dattaz biradar on 25/03/26.
//

import Foundation
import SwiftUI

struct CardStyleModifier : ViewModifier {
    let cornerRadius : CGFloat
    let backgroundColour : Color
    let padding : CGFloat
    func body(content: Content) -> some View {
        content
            .padding(padding)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(backgroundColour))
        
    }
}

extension View {
    func cardStyle(radius:CGFloat = 16, backgroundColor : Color = .white,padding:CGFloat = 16) -> some View {
        self.modifier(CardStyleModifier(cornerRadius: radius, backgroundColour: backgroundColor, padding: padding))
    }
}
