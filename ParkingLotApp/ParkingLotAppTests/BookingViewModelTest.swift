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
    private var mockAllocationService: MockAllocationService!
    private var mockDeallocationService: MockFreeUpSlotService!
    
    override func setUp() {
        super.setUp()
        mockAllocationService = MockAllocationService()
        mockDeallocationService = MockFreeUpSlotService()
        sut = BookingViewModel(allocationService: mockAllocationService,
                               deallocationService: mockDeallocationService)
    }
    
    override func tearDown() {
        mockAllocationService = nil
        mockDeallocationService = nil
        sut = nil
        super.tearDown()
    }
    
    func testGetSlotsForVehicleType() {
        let expectedTicketFormat = "[1:1]"
        sut.getSlotsForVehicleType(.small) { testTicket in
            XCTAssertEqual(expectedTicketFormat, testTicket)
            XCTAssertTrue(mockAllocationService.getSlotsCalledCount == 1)
        }
    }
    
    func testGetSlotsForVehicleType_NoSlotsFound() {
        mockAllocationService.floorId = 0
        mockAllocationService.bayId = 0
        let expectedTicketFormat = "NO SLOTS FOUND"
        sut.getSlotsForVehicleType(.small) { testTicket in
            XCTAssertEqual(expectedTicketFormat, testTicket)
            XCTAssertTrue(mockAllocationService.getSlotsCalledCount == 1)
        }
    }
    
    func testFreeSlotWithBayID() {
        sut.freeSlotWithBayID(1) { val in
            XCTAssertTrue(mockDeallocationService.freeSlotsCalledCount == 1)
        }
    }
}
