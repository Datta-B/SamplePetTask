//
//  GroupViewModel.swift
//  Sample_DogProject
//
//  Created by dattaz biradar on 16/03/26.
//

import Foundation
import Observation
import Combine

class GroupViewModel : ObservableObject {
    @Published var groupList : [Group] = []
    @Published var isLoading : Bool = false
    @Published var isErrorMessage : String?
    
    let useCase: GetGroupUseCaseProtocol
    
    init(useCase: GetGroupUseCaseProtocol) {
        self.useCase = useCase
    }
    
    @MainActor
    func getGroupList() async {
        isLoading = true
        defer{isLoading = false}
        do{
           let response = try await useCase.execute()
            groupList = response.data
        }catch{
            isErrorMessage = error.localizedDescription
        }
    }
}

// MARK:- For Mock Data
extension GroupViewModel {
    static var Mock : GroupViewModel {
        let vm = GroupViewModel(useCase: MockGroupUseCase())
        vm.groupList = [.mock]
        vm.isLoading = false
        return vm
    }
}
