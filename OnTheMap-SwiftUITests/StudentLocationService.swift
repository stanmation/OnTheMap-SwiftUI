//
//  LoginServiceTests.swift
//  OnTheMap-SwiftUITests
//
//  Created by Stanley Darmawan on 27/5/2024.
//

import Foundation
import XCTest
import Combine
@testable import OnTheMap_SwiftUI

final class StudentLocationViewModelTests: XCTestCase {
  private var viewModel: StudentLocationViewModel!
  private var mockLoginService: MockLoginService!
  private var mockStudentLocationService: MockStudentLocationService!
  private var cancellable = Set<AnyCancellable>()

  @MainActor
  override func setUp() {
    super.setUp()
    mockLoginService = MockLoginService()
    mockStudentLocationService = MockStudentLocationService()
    viewModel = StudentLocationViewModel(studentLocationService: mockStudentLocationService, loginService: mockLoginService)
  }
  
  @MainActor 
  func testRetrievingStudentLocations() {
    mockStudentLocationService.students = [Student(
      firstName: "firstName",
      lastName: "lastName",
      mediaURL: "mediaUrl",
      latitude: 1,
      longitude: 2)]

    let expectation = XCTestExpectation()
    viewModel.$students
      .sink { students in
        if let student = students.first {
          expectation.fulfill()
          XCTAssertEqual(student.firstName, "firstName")
          XCTAssertEqual(student.lastName, "lastName")
          XCTAssertEqual(student.latitude, 1)
          XCTAssertEqual(student.longitude, 2)
        }
      }
      .store(in: &cancellable)
    
    viewModel.loadStudentLocations()
    wait(for: [expectation], timeout: 1)
  }
  
  @MainActor
  func testRetrievingStudentsFailureShouldSetErrorWrapper() throws {
    mockStudentLocationService.shouldFail = true

    let expectation = XCTestExpectation()
    
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
    
    viewModel.loadStudentLocations()
    wait(for: [expectation], timeout: 1)
  }
}

class MockStudentLocationService: StudentLocationService {
  var shouldFail = false
  var students: [Student] = []

  override func getStudentLocations() async throws -> [Student] {
    if shouldFail {
      throw ServerError.technicalError("error")
    }
    return students
  }
}
