//
//  LoginView.swift
//  Sample_DogProject
//
//  Created by dattaz biradar on 16/03/26.
//

import SwiftUI

struct LoginView: View {

    @StateObject private var loginVM = LoginViewModel()
    @EnvironmentObject var coordinator: AppCoordinator
    @State private var showAlert = false

    var body: some View {
        ZStack {
            Color(AppImages.background)
                .ignoresSafeArea()
            VStack(spacing: 25){
                
                LogoView
                
                TextView
                
                TextFieldsViews(placeHolder: AppPlaceholders.email, isSecureField: false, label: AppPlaceholders.emailLabel, text: $loginVM.emailID)
                
                TextFieldsViews(placeHolder: AppPlaceholders.password, isSecureField: true, label: AppPlaceholders.passwordLabel, text: $loginVM.password)
                
                PrimaryButton(title: AppStrings.loginButton, radius: 14, backgroundColor: .appPrimary, textColor: .white,action:  {
                    loginButtonTapped()
                }, isLoading:loginVM.isLoading)
            }
            .padding(.horizontal)
            .disabled(loginVM.isError)
        }
        .overlay {
            if loginVM.isError{errorAlertOverlay}
        }
    }
    
    private var LogoView : some View {
        Image(systemName: AppImages.userIcon)
            .resizable()
            .scaledToFit()
            .frame(width: 120,height: 120)
            .foregroundColor(.appPrimary)
    }
    
    private var  TextView : some  View {
        Text(AppStrings.welcomeTitle)
            .bold()
            .font(.largeTitle)
            .foregroundColor(.appPrimary)
        
    }
    
    private var errorAlertOverlay: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
            CustomAlertView(isPresented: $loginVM.isError,title: AppStrings.loginErrorTitle,message: loginVM.errorMessage, primaryButtonLabel: AppStrings.okText, primaryButtonAction: {}, color: .appPrimary)
            .padding(.horizontal)
        }
    }
    
    func loginButtonTapped() {
        Task{
            let result = await loginVM.validateLogin()
            switch result {
            case .success:
                coordinator.loginSuccess(email: loginVM.emailID)
            case .failure(let message):
                loginVM.errorMessage = message
                loginVM.isError = true
            }
        }
    }
    
}

#Preview {
    LoginView()
}
