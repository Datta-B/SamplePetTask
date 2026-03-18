//
//  DashboardView.swift
//  Sample_DogProject
//
//  Created by dattaz biradar on 16/03/26.
//

import SwiftUI
import Observation

enum SelectionType: String, CaseIterable {
    case breeds = "Breeds"
    case groups = "Groups"
}

struct HomeView: View {
//    
//    @StateObject private var breedVM: BreedViewModel
//    @StateObject private var groupVM: GroupViewModel
    
    @EnvironmentObject var breedVM: BreedViewModel
    @EnvironmentObject var groupVM: GroupViewModel
    
    private var title: String {
        selectedType == .breeds ? "Dog Breeds" : "Dog Groups"
    }

//    init() {
//        let apiClient = NetworkManagerService()
//        
//        let breedRepo = BreedRepositoryImpl(service: apiClient)
//        let groupRepo = GroupRepositoryImpl(service: apiClient)
//        
//        let breedUseCase = GetDogBreedsUseCase(repository: breedRepo)
//        let groupUseCase = GetGroupUseCase(repository: groupRepo)
//        
//        let breedVM = BreedViewModel(useCase: breedUseCase)
//        let groupVM = GroupViewModel(useCase: groupUseCase)
//        
//        _breedVM = StateObject(wrappedValue: breedVM)
//        _groupVM = StateObject(wrappedValue: groupVM)
//    }
    
    @State var selectedType : SelectionType = .breeds
    @EnvironmentObject var router: Router
    
    var body: some View {
        VStack{
            Picker("Select", selection: $selectedType) {
                ForEach(SelectionType.allCases, id: \.self) { type in
                    Text(type.rawValue)
                }
            }
            .pickerStyle(.segmented)
            .padding()
            if selectedType == .breeds{
                if breedVM.isLoading{
                    Spacer()
                    ProgressView {
                        Text("Fetching data...")
                    }
                    .tint(.green)
                    Spacer()
                }else{
                    List(breedVM.breedList){ breed in
                        NavigationLink(value: AppRoute.breedDetail(breed)) {
                            RowView(name: breed.attributes.name, image: Image("dummyImage"))
                        }
                    }
                }
            }else{
                if groupVM.isLoading{
                    Spacer()
                    ProgressView {
                        Text("Fetching data...")
                    }
                    .tint(.green)
                    Spacer()
                }else{
                    List(groupVM.groupList){ group in
                        RowView(name: group.attributes.name, image: Image("dummyImage"))
                    }
                }
                
            }
            
        }
        .navigationTitle(title)
        .task { await loadCurrentList() }
        .onChange(of: selectedType) { oldValue, newValue in
            Task {
                await loadCurrentList()
            }
        }
    }
    
    //
    private func loadCurrentList() async {
        if selectedType == .breeds {
            if breedVM.breedList.isEmpty{
                await breedVM.getBreedList()
                
            }
        } else {
            if groupVM.groupList.isEmpty{
                await groupVM.getGroupList()
                
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(Router())
}
