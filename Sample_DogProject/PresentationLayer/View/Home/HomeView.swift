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
    @EnvironmentObject var router: HomeRouter

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
    let columns = [GridItem(.flexible()),GridItem(.flexible())]
    var body: some View {
        if groupVM.isLoading {
            LoadingView()
        } else {
            ScrollView{
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(groupVM.groupList) { group in
                        GeometryReader { geo in
                            VStack(spacing: 12) {
                                Image(AppImages.dogImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 60, height: 60)
                                    .clipShape(Circle())
                                    .padding(.top, 2)
                                
                                Text(group.attributes.name).bold()
                                    .lineLimit(2)
                                    .multilineTextAlignment(.center)
                                    .frame(maxWidth: .infinity)
                            }
                            .frame(width: geo.size.width, height: geo.size.width)
                            .background(Color.cyan.opacity(0.4))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .shadow(radius: 8)
                            //.customShadow()
                            
                        }
                        .padding()
                        .frame(width:UIScreen.main.bounds.width/2 - 10,height: 150)
                    }
                }
            }
//            ScrollView{
//                ForEach(groupVM.groupList) { group in
//                    RowView(name: group.attributes.name, image: Image(AppImages.dummyImage))
//                }
//            }
        }
    }
}


#Preview {
    HomeView()
        .environmentObject(HomeRouter())
        .environmentObject({
            let vm = BreedViewModel(useCase: MockBreedUseCase())
            vm.breedList = [Breed.mock]
            return vm
        }())
        .environmentObject({
            let vm = GroupViewModel(useCase: MockGroupUseCase())
            vm.groupList = [Group.mock]
            return vm
        }())
}
