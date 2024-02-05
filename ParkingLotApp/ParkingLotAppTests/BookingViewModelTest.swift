//
//  BookingViewModelTest.swift
//  ParkingLotAppTests
//
//  Created by Ronak Malick on 06/02/24.
//

import XCTest
@testable import ParkingLotApp

final class BookingViewModelTest: XCTestCase {

    private var sut: BookingViewModel!
    private var mockService: MockParkingLotService!
    
    override func setUp() {
        super.setUp()
        mockService = MockParkingLotService()
        sut = BookingViewModel(service: mockService)
    }
    
    override func tearDown() {
        mockService = nil
        sut = nil
        super.tearDown()
    }
    
    func testGetSlotsForVehicleType() {
        let expectedTicketFormat = "[1:1]"
        sut.getSlotsForVehicleType(.small) { testTicket in
            XCTAssertEqual(expectedTicketFormat, testTicket)
            XCTAssertTrue(mockService.getSlotsCalledCount == 1)
        }
    }
    
    func testGetSlotsForVehicleType_NoSlotsFound() {
        mockService.floorId = 0
        mockService.bayId = 0
        let expectedTicketFormat = "NO SLOTS FOUND"
        sut.getSlotsForVehicleType(.small) { testTicket in
            XCTAssertEqual(expectedTicketFormat, testTicket)
            XCTAssertTrue(mockService.getSlotsCalledCount == 1)
        }
    }
    
    func testFreeSlotWithBayID() {
        sut.freeSlotWithBayID(1) { val in
            XCTAssertTrue(mockService.freeSlotsCalledCount == 1)
        }
    }
}
