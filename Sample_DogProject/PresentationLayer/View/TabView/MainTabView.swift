//
//  MainTabView.swift
//  Sample_DogProject
//
//  Created by dattaz biradar on 16/03/26.
//

import SwiftUI

struct MainTabView: View {
    
    @StateObject var router = Router()
    @StateObject var profileRouter = Router()
    @EnvironmentObject var coordinator: AppCoordinator
    
    @StateObject private var breedVM: BreedViewModel
    @StateObject private var groupVM: GroupViewModel
    
    init() {
        let apiClient = NetworkManagerService()
        let breedRepo = BreedRepositoryImpl(service: apiClient)
        let groupRepo = GroupRepositoryImpl(service: apiClient)
        let breedUseCase = GetDogBreedsUseCase(repository: breedRepo)
        let groupUseCase = GetGroupUseCase(repository: groupRepo)
        
        _breedVM = StateObject(wrappedValue: BreedViewModel(useCase: breedUseCase))
        _groupVM = StateObject(wrappedValue: GroupViewModel(useCase: groupUseCase))
    }

    
       var body: some View {
           TabView {
               NavigationStack(path: $router.path) {
                   HomeView()
                       .environmentObject(breedVM)
                       .environmentObject(groupVM)
                       .navigationDestination(for: AppRoute.self) { route in
                           switch route {

                           case .breedDetail(let breed):
                               BreedDetailView(breed: breed)
                           }
                       }
               }
               .tabItem {
                   Label("Dashboard", systemImage: "house")
               }
               NavigationStack(path: $profileRouter.path) {
                  MyProfileView()
                       
               }
               .tabItem {
                   Label("Profile", systemImage: "person")
               }
           }
           .environmentObject(router)
           .environmentObject(coordinator)
       }
}

#Preview {
    MainTabView()
}
