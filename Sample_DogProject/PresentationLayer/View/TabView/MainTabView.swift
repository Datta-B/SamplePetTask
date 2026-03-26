//
//  MainTabView.swift
//  Sample_DogProject
//
//  Created by dattaz biradar on 16/03/26.
//

import SwiftUI

struct MainTabView: View {
    
    @StateObject var homeRouter = HomeRouter()
    @StateObject var profileRouter = ProfileRouter()
    @EnvironmentObject var coordinator: AppFlowCoordinator
    
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
               NavigationStack(path: $homeRouter.path) {
                   HomeView()
                       .environmentObject(breedVM)
                       .environmentObject(groupVM)
                       .navigationDestination(for: HomeRoute.self) { route in
                           destination(for: route)
                       }
               }
               .tabItem {
                   Label(TabName.dashboard, systemImage: TabIcon.dashboard)
               }
               NavigationStack(path: $profileRouter.path) {
                  MyProfileView()
                       
               }
               .tabItem {
                   Label(TabName.profile, systemImage: TabIcon.profile)
               }
           }
           .environmentObject(homeRouter)
           .environmentObject(coordinator)
       }
    
    
    ///  Breed
    @ViewBuilder
       private func destination(for route: HomeRoute) -> some View {
           switch route {
           case .breedDetail(let breed):
               BreedDetailView(breed: breed)
           }
       }
    
}

#Preview {
    MainTabView()
}
