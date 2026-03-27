//
//  SplashScreen.swift
//  Sample_DogProject
//
//  Created by dattaz biradar on 27/03/26.
//

import SwiftUI

struct SplashScreen: View {
    @State private var animateDog = false
    
    var body: some View {
        ZStack {
            Image(AppImages.dogImage)
                .resizable()
                .scaleEffect(animateDog ? 1.0 : 0.8)
                .opacity(animateDog ? 1 : 0.5)
                .animation(.easeInOut(duration: 2.0).repeatForever(autoreverses: true), value: animateDog)
            
        }.ignoresSafeArea()
        .onAppear {animateDog = true}
    }
}

#Preview {
    SplashScreen()
}
