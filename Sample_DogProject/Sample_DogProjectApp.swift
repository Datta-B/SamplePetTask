//
//  Sample_DogProjectApp.swift
//  Sample_DogProject
//
//  Created by dattaz biradar on 16/03/26.
//

import SwiftUI

@main
struct Sample_DogProjectApp: App {
    @State var coordinator = AppFlowCoordinator()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(coordinator)
        }
    }
}
