//
//  AuthViewModelTest.swift
//  ParkingLotAppTests
//
//  Created by Ronak Malick on 06/02/24.
//

import XCTest
@testable import ParkingLotApp

final class AuthViewModelTest: XCTestCase {
    private var sut: AuthViewModel!
    private var mockService: MockParkingLotService!

    override func setUp() {
        super.setUp()
        mockService = MockParkingLotService()
        sut = AuthViewModel(service: mockService)
    }
    
    override func tearDown() {
        mockService = nil
        sut = nil
        super.tearDown()
    }

    func testSetupParkingLot() {
        sut.setupParkingLot(floors: 1, small: 2, medium: 2, large: 2, xL: 2) { val in
            XCTAssertTrue(val)
            XCTAssertTrue(mockService.setupParkingLotSpaceCount == 1)
        }
    }
}
