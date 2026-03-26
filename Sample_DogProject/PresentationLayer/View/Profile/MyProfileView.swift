//
//  MyProfileView.swift
//  Sample_DogProject
//
//  Created by dattaz biradar on 16/03/26.
//

import SwiftUI

struct MyProfileView: View {
    
    @EnvironmentObject var coordinator: AppFlowCoordinator
    @State var showAlert : Bool = false
    
    var body: some View {
        ZStack {
            Color(.background)
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                
                ProfileHeader(email: coordinator.userEmail)
                
                VStack(spacing: 16) {
                    
                    ProfileMenuItemView(icon: AppImages.settings, title: AppStrings.Settings){}
                    
                    ProfileMenuItemView(icon: AppImages.notifications, title: AppStrings.Notification){}
                    
                    ProfileMenuItemView(icon: AppImages.HelpAndSupport, title: AppStrings.HelpAndSupport){}
                    
                    LogOutButton(action: {
                        showAlert.toggle()
                    }, title: AppStrings.loginButton)
                }
            }
            .padding(.horizontal, 32)
            .padding(.top, 16)
        }
        .padding(.top, 40)
        .disabled(showAlert)
        .overlay {
            if showAlert{
                ShowAlert(showAlert: $showAlert)
            }
        }
    }
}



struct ProfileHeader: View {
    let email: String
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: AppImages.userIcon)
                .fontStyle(size: 80, color: .appPrimary)
            Text(email)
                .fontStyle(size: 16, color: .secondary)
        }
    }
}

struct ShowAlert : View {
    @Binding var showAlert : Bool
    @EnvironmentObject var coordinator: AppFlowCoordinator

    var body: some View {
        CustomAlertView(isPresented: $showAlert,message: AppStrings.logoutText, primaryButtonLabel: AppStrings.Yes, primaryButtonAction: {
            coordinator.logout()
        },secondaryButtonLabel: AppStrings.No,secondaryButtonAction: {
            showAlert.toggle()
        }, color: .appPrimary)
        .padding(.horizontal,24)
    }
}

#Preview {
    MyProfileView()
        .environmentObject(AppFlowCoordinator())
}
