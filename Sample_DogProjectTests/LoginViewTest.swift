//
//  LoginViewTest.swift
//  Sample_DogProjectTests
//
//  Created by dattaz biradar on 17/03/26.
//

import XCTest
@testable import Sample_DogProject

@MainActor
final class LoginViewTest: XCTestCase {
    
    var loginVm : LoginViewModel!
    
    override func setUp() {
        super.setUp()
        loginVm = LoginViewModel()
    }
    
    override func tearDown() {
        loginVm = nil
        super.tearDown()
    }
    
    func testValidateLogin() async {
        
        loginVm.emailID =  "test@example.com"
        loginVm.password = "1234"
        
        let result = await loginVm.validateLogin()
        
        switch result {
        case .success:
            XCTAssertTrue(true)
        case .failure(let message):
            XCTFail("Expected Success but got failure:\(message)")
        }
    }
    
    func testEmptyEmail() async {
        
        loginVm.emailID  =  ""
    
        let result = await loginVm.validateLogin()
        
        switch result {
        case .success:
            XCTFail("Expected failure due to Empty Email")
        case .failure(let message):
            XCTAssertEqual(message, "Email ID Can't be empty")
        }
    }
    
    func testEmptyPassword() async {
        
        loginVm.emailID = "test@example.com"
        loginVm.password  =  ""
    
        let result = await loginVm.validateLogin()
        
        switch result {
        case .success:
            XCTFail("Expected failure due to Empty password")
        case .failure(let message):
            XCTAssertEqual(message, "Password Can't be empty")
        }
    }
    
    func testInvalidEmail() async {
        loginVm.emailID = "invalid-email"
        loginVm.password = "password123"
        
        let result = await loginVm.validateLogin()
        
        switch result {
        case .success:
            XCTFail("Expected failure due to invalid email")
        case .failure(let message):
            XCTAssertEqual(message, "Invalid email address")
        }
    }
    
    func testIncorrectPassword() async {
        
        loginVm.emailID = "test@example.com"
        loginVm.password = "123456"
        
        let result = await loginVm.validateLogin()
        
        switch result {
        case .success:
            XCTFail("Expected failure due to incorrect password")
        case .failure(let message):
            XCTAssertEqual(message, "Incorrect password")
        }
    }
}
