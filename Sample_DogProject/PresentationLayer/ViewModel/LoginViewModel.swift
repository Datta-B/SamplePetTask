//
//  LoginViewModel.swift
//  Sample_DogProject
//
//  Created by dattaz biradar on 16/03/26.
//

import Foundation
import Combine


enum LoginValidationResult {
    case success
    case failure(String)
}

class LoginViewModel: ObservableObject {
    @Published var emailID: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String = ""
    @Published var isLoading : Bool = false
    @Published var isError : Bool = false


    func validateLogin() async -> LoginValidationResult {
        isLoading = true
        defer{isLoading = false}
        
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        
        let trimmedEmail = emailID.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedPassword = password.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedEmail.isEmpty else {
            return .failure(LoginValidationStrings.emptyEmail)
        }
        
        guard !trimmedPassword.isEmpty else {
            return .failure(LoginValidationStrings.emptyPassword)
        }
        
        guard isValidEmail(trimmedEmail) else {
            return .failure(LoginValidationStrings.invalidEmail)
        }
        
        guard trimmedPassword == LoginValidationStrings.correctPassword else {
            return .failure(LoginValidationStrings.incorrectPassword)
        }
        return .success
    }

    private func isValidEmail(_ email: String) -> Bool {
        let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: email)
    }
}
