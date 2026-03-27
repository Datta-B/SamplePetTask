//
//  BreedViewModelTest.swift
//  Sample_DogProjectTests
//
//  Created by dattaz biradar on 17/03/26.
//

import XCTest
@testable import Sample_DogProject

@MainActor
final class BreedViewModelTest: XCTestCase {

      var mockAPIClient : MockAPIClient!
      var repository    : DogBreedRepository!
      var useCase       : GetDogBreedsUseCaseProtocol!
      var viewModel     : BreedViewModel!
    
    override func setUp() {
        super.setUp()
        mockAPIClient = MockAPIClient()
        repository    = BreedRepositoryImpl(service: mockAPIClient)
        useCase       = GetDogBreedsUseCase(repository: repository)
        viewModel = BreedViewModel(useCase: useCase)
    }
    
    override func tearDown() {
        mockAPIClient = nil
        repository     = nil
        useCase        = nil
        viewModel      = nil
        super.tearDown()
    }
   
    func testFetchDogsSuccess() async {
        // Prepare mock data
        let dogs = DogBreedsResponse(data: [Breed.mock])
        let data = try! JSONEncoder().encode(dogs)
        mockAPIClient.response = .success(data)
        
        await viewModel.getBreedList()
        
        XCTAssertEqual(viewModel.breedList.count, 1)
        XCTAssertNil(viewModel.isErrorMessage)
    }
    
    func testFetchDogsWithFailure() async {
        
        mockAPIClient.response = .failure(APIError.serverError(500))
        
        await viewModel.getBreedList()
        
        XCTAssertTrue(viewModel.breedList.isEmpty)
        XCTAssertNotNil(viewModel.isErrorMessage)
        
    }

}
