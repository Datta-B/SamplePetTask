//
//  MyProfileView.swift
//  Sample_DogProject
//
//  Created by dattaz biradar on 16/03/26.
//

import SwiftUI

struct MyProfileView: View {
    
    @EnvironmentObject var coordinator: AppCoordinator
    
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                Image(systemName: "person.circle.fill")
                    .font(.system(size: 80))
                    .foregroundColor(Color("AppPrimary"))
                
                Text(coordinator.userEmail)
                    .font(.system(size: 16))
                    .foregroundColor(.secondary)
                
                
                VStack(spacing: 16) {
                    profileMenuItemView(icon: "gear", title: "Settings"){}
                    profileMenuItemView(icon: "bell", title: "Notifications"){}
                    profileMenuItemView(icon: "questionmark.circle", title: "Help & Support"){}
                    
                    Button {
                        coordinator.logout()
                    } label: {
                        HStack(spacing: 12) {
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                                .font(.system(size: 20))
                            
                            Text("Logout")
                                .font(.system(size: 17, weight: .medium))
                            
                            Spacer()
                        }
                        .foregroundColor(.red)
                        .padding(16)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.white)
                        )
                    }
                }
                .padding(.horizontal, 32)
                .padding(.top, 16)
            }
            .padding(.top, 40)
            
          }
      }
    }



#Preview {
    MyProfileView()
        .environmentObject(AppCoordinator())
}
