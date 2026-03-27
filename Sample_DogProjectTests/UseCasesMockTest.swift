//
//  UseCasesMockTest.swift
//  Sample_DogProjectTests
//
//  Created by dattaz biradar on 27/03/26.
//

import XCTest
@testable import Sample_DogProject

@MainActor
final class UseCasesMockTest: XCTestCase {
    
    func testMockBreedUseCase_returnsExpectedResponse() async throws {
        let useCase = MockBreedUseCase()
        
        let response = try await useCase.execute()
        
        XCTAssertEqual(response.data.count, 1)
        XCTAssertEqual(response.data.first, Breed.mock)
    }
    
    func testMockGroupUseCase_returnsExpectedResponse() async throws {
        let useCase = MockGroupUseCase()
        
        let response = try await useCase.execute()
        
        XCTAssertEqual(response.data.count, 1)
        XCTAssertEqual(response.data.first, Group.mock)
    }
}



