//
//  OnTheMap_SwiftUITests.swift
//  OnTheMap-SwiftUITests
//
//  Created by Stanley Darmawan on 2/5/2024.
//

import XCTest
import Combine
@testable import OnTheMap_SwiftUI

final class LoginViewModelTests: XCTestCase {
  var viewModel: LoginViewModel!
  var mockLoginService: MockLoginService!
  private var cancellable = Set<AnyCancellable>()

  @MainActor 
  override func setUp() {
    super.setUp()
    mockLoginService = MockLoginService()
    viewModel = LoginViewModel(loginService: mockLoginService)
  }

  override func tearDown() {
    mockLoginService = nil
    viewModel = nil
    super.tearDown()
  }
  
  @MainActor
  func testLoginSuccessShouldNavigateToStudentLocationPage() {
    let expectation = XCTestExpectation()
    
    viewModel.$nextPage
      .sink { nextPage in
        switch nextPage {
        case .studentLocation(let loginService):
          expectation.fulfill()
          XCTAssertNotNil(loginService)
        default:
          break
        }
      }
      .store(in: &cancellable)
    
    viewModel.login(email: "email", password: "password")
    wait(for: [expectation], timeout: 1)
  }
  
  @MainActor
  func testLoginFailureShouldSetErrorWrapper() throws {
    mockLoginService.shouldFail = true

    let expectation = XCTestExpectation()
  
    viewModel.$nextPage
      .sink(
        receiveValue: { nextPage in
          if nextPage != nil {
            XCTFail()
          }
        }
      )
      .store(in: &cancellable)
    
    viewModel.$errorWrapper
      .sink(
        receiveValue: { errorWrapper in
          if let errorWrapper = errorWrapper {
            XCTAssertEqual(errorWrapper.message, "error")
            expectation.fulfill()
          }
        }
      )
      .store(in: &cancellable)
    
    viewModel.login(email: "email", password: "password")
    wait(for: [expectation], timeout: 1)
  }
}

class MockLoginService: LoginService {
  var shouldFail = false
  
  override func getSession(username: String, password: String) async throws -> SessionResponse {
    if shouldFail {
      throw ServerError.technicalError("error")
    }
    return SessionResponse(account: SessionResponse.Account(key: "accountKey"), session: SessionResponse.Session(id: "SessionId"))
  }
  
  override func getPublicUserData(session: SessionResponse) async throws -> UserDataResponse {
    if shouldFail {
      throw ServerError.technicalError("error")
    }
    return UserDataResponse(lastName: "lastName", firstName: "firstName")
  }
}
