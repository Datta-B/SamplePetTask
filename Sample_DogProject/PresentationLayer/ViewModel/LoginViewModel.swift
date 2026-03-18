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
        
        guard  !emailID.isEmpty, emailID != " " else{
            return .failure("Email ID Can't be empty")
        }
        guard  !password.isEmpty, password != " " else{
            return .failure("Password Can't be empty")
        }
    
        guard isValidEmail(emailID) else {
            return .failure("Invalid email address")
        }

        guard password != "123456" else {
            return .failure("Incorrect password")
        }
        return .success
    }

    private func isValidEmail(_ email: String) -> Bool {
        let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: email)
    }
}
