//
//  GroupViewModelTest.swift
//  Sample_DogProjectTests
//
//  Created by dattaz biradar on 17/03/26.
//

import XCTest
@testable import Sample_DogProject


@MainActor
final class GroupViewModelTest: XCTestCase {
    
    
    var mockAPIClient : MockAPIClient!
    var repository    : GroupRepository!
    var useCase       : GetGroupUseCaseProtocol!
    var viewModel     : GroupViewModel!
    
    override func setUp() {
        super.setUp()
        mockAPIClient = MockAPIClient()
        repository    = GroupRepositoryImpl(service: mockAPIClient)
        useCase       = GetGroupUseCase(repository: repository)
        viewModel     = GroupViewModel(useCase: useCase)
    }
    
    override func tearDown() {
        mockAPIClient = nil
        repository     = nil
        useCase        = nil
        viewModel      = nil
        super.tearDown()
    }
    
    func testFetchGroupSuccess() async {
        
        let group = GroupResponse(data: [Group.mock])
        let data = try! JSONEncoder().encode(group)
        
        mockAPIClient.response = .success(data)
        
        
        await viewModel.getGroupList()
        XCTAssertEqual(viewModel.groupList.count, 1)
    }
    
    func testFetchGroupWithFailure() async {
        
        mockAPIClient.response = .failure(APIError.serverError(500))
        
        await viewModel.getGroupList()
        
        XCTAssertTrue(viewModel.groupList.isEmpty)
        XCTAssertNotNil(viewModel.isErrorMessage)
        
    }
}
