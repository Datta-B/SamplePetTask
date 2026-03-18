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
                    .font(.system(size: 20))
                    .foregroundColor(Color("AppPrimary"))
                
                Text(title)
                    .font(.system(size: 17, weight: .medium))
                    .foregroundColor(.primary)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.white)
            )
        }
    }
}

#Preview {
    profileMenuItemView(icon: "", title: "Test"){}
}

