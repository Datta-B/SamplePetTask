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
    @State private var isActive = true
    
    var body: some Scene {
        WindowGroup {
            if isActive{
                SplashScreen()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                isActive.toggle()
                            }
                        }
                    }
            }else{
                RootView()
                    .environmentObject(coordinator)
            }
        }
    }
}
