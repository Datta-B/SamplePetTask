//
//  PrimaryButton.swift
//  Sample_DogProject
//
//  Created by dattaz biradar on 25/03/26.
//

import Foundation
import SwiftUI

struct PrimaryButton: View {
    let title: String
    let radius: CGFloat
    let backgroundColor: Color
    let textColor: Color
    let action: () -> Void
    var isLoading: Bool = false
    
    var body: some View {
        Button(action: action) {
            if isLoading {
                ProgressView()
                    .tint(textColor)
            } else {
                Text(title)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(textColor)
            }
        }
        .padding()
        .background(backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: radius))
        .disabled(isLoading)
        .animation(.easeInOut(duration: 0.25), value: isLoading)
    }
}

struct LogOutButton : View {
    let action: () -> Void
    let title : String
    let color : Color = .red
    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: 12) {
                Image(systemName: AppImages.logoutImage)
                    .font(.system(size: 20))
                
                Text(title)
                    .font(.system(size: 17, weight: .medium))
                
                Spacer()
            }
            .foregroundColor(color)
            .cardStyle()
        }
    }
}
