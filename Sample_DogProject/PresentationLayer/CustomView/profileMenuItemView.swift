//
//  profileMenuItemView.swift
//  Sample_DogProject
//
//  Created by dattaz biradar on 17/03/26.
//

import SwiftUI

struct profileMenuItemView: View {
    let icon: String
    let title: String
    let action : () -> ()
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .fontStyle(size: 20,color: .appPrimary)
                Text(title)
                    .fontStyle(size: 17,weight: .medium,color: .appPrimary)
                Spacer()
                
                Image(systemName: AppImages.chevronImage)
                    .fontStyle(size: 14,color: .primary)
            }
            .cardStyle()
        }
    }
}

#Preview {
    profileMenuItemView(icon: "", title: "Test"){}
}

