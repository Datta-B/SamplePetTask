//
//  BreedViewModel.swift
//  Sample_DogProject
//
//  Created by dattaz biradar on 16/03/26.
//

import Foundation
import Combine
import Observation

class BreedViewModel : ObservableObject {
    @Published var breedList : [Breed] = []
    @Published var isLoading : Bool = false
    @Published var isErrorMessage : String?
    let useCase: GetDogBreedsUseCaseProtocol
    
    
    init(useCase: GetDogBreedsUseCaseProtocol) {
        print("called init")
        self.useCase = useCase
    }
    
    @MainActor
    func getBreedList() async {
        isLoading = true
        defer{isLoading = false}
        do{
           let response = try await useCase.execute()
            breedList = response.data
        }catch{
            isErrorMessage = error.localizedDescription
        }
    }
}


