//
//  RootView.swift
//  Sample_DogProject
//
//  Created by dattaz biradar on 16/03/26.
//

import Foundation
import SwiftUI


struct RootView: View {

    @StateObject var coordinator = AppCoordinator()

    var body: some View {

        switch coordinator.state {

        case .login:
            LoginView()
                .environmentObject(coordinator)

        case .main:
            MainTabView()
                .environmentObject(coordinator)
        }
    }
}
