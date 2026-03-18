//
//  AppCordinator.swift
//  Sample_DogProject
//
//  Created by dattaz biradar on 16/03/26.
//

import Foundation
import Combine
import SwiftUI

class AppCoordinator: ObservableObject {
    
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
    @AppStorage("userEmail") var userEmail: String = ""
    
    enum AppState {
        case login
        case main
    }
 
    
    @Published var state: AppState = .login
    init() {
            state = isLoggedIn ? .main : .login
        }

        func loginSuccess(email: String) {
            userEmail = email
            isLoggedIn = true
            state = .main
        }

        func logout() {
            isLoggedIn = false
            userEmail = ""
            state = .login
        }
}
