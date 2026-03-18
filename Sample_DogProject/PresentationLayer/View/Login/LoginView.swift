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
    
    var body: some View {
        ZStack {
            Color("background")
                .ignoresSafeArea()
            VStack(spacing: 25){
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 110, height: 110)
                    .foregroundColor(.appPrimary)
                Text("Welcome Back")
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(.appPrimary)

                TextFieldsViews(placeHolder: "sample@gmail.com", isSecureField: false, label: "Email Address", text: $loginVM.emailID)
                TextFieldsViews(placeHolder: "*******", isSecureField: true, label: "Password", text: $loginVM.password)
                Button {
                   loginButtonTapped()
                } label: {
                    buttonType
                }
                .padding()
                .background(Color.appPrimary)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 14))
                .disabled(loginVM.isLoading)
                .animation(.easeInOut(duration: 0.25), value: loginVM.isLoading)
                
            }
            .padding(.horizontal)
            .alert(isPresented: $loginVM.isError) {
                Alert(
                    title: Text("Login Error"),
                    message: Text(loginVM.errorMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
            
        }
    }
    
    func loginButtonTapped() {
        Task{
            let result = await loginVM.validateLogin()
            switch result {
            case .success:
                print("Login successful")
                coordinator.loginSuccess(email: loginVM.emailID)
            case .failure(let message):
                loginVM.errorMessage = message
                loginVM.isError = true
            }
        }
    }
    
    @ViewBuilder
    private var buttonType : some View {
        if loginVM.isLoading {
            ProgressView()
                .tint(.white)
        }else {
            Text("Login")
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    LoginView()
}
