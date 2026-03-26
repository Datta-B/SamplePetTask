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
    @EnvironmentObject var breedVM: BreedViewModel
    @EnvironmentObject var groupVM: GroupViewModel
//    @EnvironmentObject var router: Router
    
    @State private var selectedType: SelectionType = .breeds
    
    private var title: String {
        selectedType == .breeds ? HomeStrings.breedsTitle : HomeStrings.groupsTitle
    }
    
    var body: some View {
        VStack {
            SelectionPicker(selectedType: $selectedType)
            currentListView
        }
        .navigationTitle(title)
        .task { await loadCurrentList() }
        .onChange(of: selectedType) { _, _ in
            Task { await loadCurrentList() }
        }
    }
    
    private func loadCurrentList() async {
        if selectedType == .breeds, breedVM.breedList.isEmpty {
            await breedVM.getBreedList()
        } else if selectedType == .groups, groupVM.groupList.isEmpty {
            await groupVM.getGroupList()
        }
    }
    
    @ViewBuilder
    private var currentListView: some View {
        switch selectedType {
        case .breeds:
            BreedListView(breedVM: breedVM)
        case .groups:
            GroupListView(groupVM: groupVM)
        }
    }

}

// MARK: - Subviews

/// Segmented Picker
private struct SelectionPicker: View {
    @Binding var selectedType: SelectionType
    
    var body: some View {
        Picker(HomeStrings.select, selection: $selectedType) {
            ForEach(SelectionType.allCases, id: \.self) { type in
                Text(type.rawValue)
            }
        }
        .pickerStyle(.segmented)
        .padding()
    }
}

/// Loading State
private struct LoadingView: View {
    var body: some View {
        Spacer()
        ProgressView {
            Text(HomeStrings.fetchingData)
        }
        .tint(.green)
        Spacer()
    }
}

/// Breed List
private struct BreedListView: View {
    @ObservedObject var breedVM: BreedViewModel
    @EnvironmentObject var router: Router

    var body: some View {
        if breedVM.isLoading {
            LoadingView()
        } else {
            ScrollView{
                ForEach(breedVM.breedList) { breed in
                    Button {
                        router.push(.breedDetail(breed))
                    } label: {
                        RowView(name: breed.attributes.name, image: Image(AppImages.dummyImage))
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
}

private struct GroupListView: View {
    @ObservedObject var groupVM: GroupViewModel
    
    var body: some View {
        if groupVM.isLoading {
            LoadingView()
        } else {
            ScrollView{
                ForEach(groupVM.groupList) { group in
                    RowView(name: group.attributes.name, image: Image(AppImages.dummyImage))
                }
            }
        }
    }
}


#Preview {
    HomeView()
        .environmentObject(Router())
        
        
}
