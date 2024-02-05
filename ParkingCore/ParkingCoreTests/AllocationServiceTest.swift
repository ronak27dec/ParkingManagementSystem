//
//  AllocationServiceTest.swift
//  ParkingCoreTests
//
//  Created by Ronak Malick on 06/02/24.
//

import XCTest
@testable import ParkingCore

final class AllocationServiceTest: XCTestCase {
    private var sut: AllocationService!
    private var mockService: ParkingLotService!
    
    override func setUp() {
        super.setUp()
        mockService = ParkingLotService()
        LocalStorage.shared.clearAll()
        mockService.setupParkingLotSpace(floors: 1, small: 2, medium: 2, large: 2, xL: 2)
        sut = AllocationService()
    }
    
    override func tearDown() {
        mockService = nil
        sut = nil
        super.tearDown()
    }

    func testGetSlotsForSmallVehicle() {
        let slots = sut.getSlots(size: .small)
        XCTAssertNotNil(slots, "Slots should not be nil")
        XCTAssertTrue(slots.floorId == 1 && slots.bayId > 0, "Incorrect slots allocated for a small vehicle")
    }
    
    func testGetSlotsForMediumVehicle() {
        let slots = sut.getSlots(size: .medium)
        XCTAssertNotNil(slots, "Slots should not be nil")
        XCTAssertTrue(slots.floorId == 1 && slots.bayId > 0, "Incorrect slots allocated for a small vehicle")
    }
    
    func testGetSlotsForLargeVehicle() {
        let slots = sut.getSlots(size: .large)
        XCTAssertNotNil(slots, "Slots should not be nil")
        XCTAssertTrue(slots.floorId == 1 && slots.bayId > 0, "Incorrect slots allocated for a small vehicle")
    }
    
    func testGetSlotsForXLVehicle() {
        let slots = sut.getSlots(size: .extraLarge)
        XCTAssertNotNil(slots, "Slots should not be nil")
        XCTAssertTrue(slots.floorId == 1 && slots.bayId > 0, "Incorrect slots allocated for a small vehicle")
    }
    
    func testAllocateForSmallVehicleIntoMediumWhenUnavailable() {
        LocalStorage.shared.model = [
            ParkingLot(bayId: 1, floor: .first, size: .small, isAvailable: false),
            ParkingLot(bayId: 5, floor: .first, size: .small, isAvailable: false),
            ParkingLot(bayId: 2, floor: .first, size: .medium, isAvailable: true)
        ]
        sut.allocateForSmallVehicle()
        
        XCTAssertFalse(LocalStorage.shared.model.isEmpty, "Medium slot is allocated when small is unavailable for a small vehicle")
        XCTAssertEqual(LocalStorage.shared.floorId, 1)
        XCTAssertEqual(LocalStorage.shared.bayId, 2)
    }
    
    func testAllocateForSmallVehicleIntoLargeWhenUnavailable() {
        LocalStorage.shared.model = [
            ParkingLot(bayId: 1, floor: .first, size: .small, isAvailable: false),
            ParkingLot(bayId: 5, floor: .first, size: .small, isAvailable: false),
            ParkingLot(bayId: 2, floor: .first, size: .medium, isAvailable: false),
            ParkingLot(bayId: 6, floor: .first, size: .medium, isAvailable: false),
            ParkingLot(bayId: 3, floor: .first, size: .large, isAvailable: true)
        ]
        sut.allocateForSmallVehicle()
        
        XCTAssertFalse(LocalStorage.shared.model.isEmpty, "Large slot is allocated when small & medium is unavailable for a small vehicle")
        XCTAssertEqual(LocalStorage.shared.floorId, 1)
        XCTAssertEqual(LocalStorage.shared.bayId, 3)
    }
    
    func testAllocateForSmallVehicleIntoXLWhenUnavailable() {
        LocalStorage.shared.model = [
            ParkingLot(bayId: 1, floor: .first, size: .small, isAvailable: false),
            ParkingLot(bayId: 5, floor: .first, size: .small, isAvailable: false),
            ParkingLot(bayId: 2, floor: .first, size: .medium, isAvailable: false),
            ParkingLot(bayId: 6, floor: .first, size: .medium, isAvailable: false),
            ParkingLot(bayId: 3, floor: .first, size: .large, isAvailable: false),
            ParkingLot(bayId: 7, floor: .first, size: .large, isAvailable: false),
            ParkingLot(bayId: 4, floor: .first, size: .extraLarge, isAvailable: true),
            ParkingLot(bayId: 8, floor: .first, size: .extraLarge, isAvailable: true),
        ]
        sut.allocateForSmallVehicle()
        
        XCTAssertFalse(LocalStorage.shared.model.isEmpty, "XL slot is allocated when small & medium & large is unavailable for a small vehicle")
        XCTAssertEqual(LocalStorage.shared.floorId, 1)
        XCTAssertEqual(LocalStorage.shared.bayId, 4)
    }
    
    func testAllocateForMediumVehicleIntoLargeWhenUnavailable() {
        LocalStorage.shared.model = [
            ParkingLot(bayId: 2, floor: .first, size: .medium, isAvailable: false),
            ParkingLot(bayId: 6, floor: .first, size: .medium, isAvailable: false),
            ParkingLot(bayId: 3, floor: .first, size: .large, isAvailable: true)
        ]
        sut.allocateForMediumVehicle()
        
        XCTAssertFalse(LocalStorage.shared.model.isEmpty, "Large slot is allocated when small & medium is unavailable for a small vehicle")
        XCTAssertEqual(LocalStorage.shared.floorId, 1)
        XCTAssertEqual(LocalStorage.shared.bayId, 3)
    }
    
    func testAllocateForMediumVehicleIntoXLWhenUnavailable() {
        LocalStorage.shared.model = [
            ParkingLot(bayId: 2, floor: .first, size: .medium, isAvailable: false),
            ParkingLot(bayId: 6, floor: .first, size: .medium, isAvailable: false),
            ParkingLot(bayId: 4, floor: .first, size: .extraLarge, isAvailable: true)
        ]
        sut.allocateForMediumVehicle()
        
        XCTAssertFalse(LocalStorage.shared.model.isEmpty, "Large slot is allocated when small & medium is unavailable for a small vehicle")
        XCTAssertEqual(LocalStorage.shared.floorId, 1)
        XCTAssertEqual(LocalStorage.shared.bayId, 4)
    }
    
    func testAllocateForLargeVehicleIntoXLWhenUnavailable() {
        LocalStorage.shared.model = [
            ParkingLot(bayId: 3, floor: .first, size: .large, isAvailable: false),
            ParkingLot(bayId: 7, floor: .first, size: .large, isAvailable: false),
            ParkingLot(bayId: 4, floor: .first, size: .extraLarge, isAvailable: true)
        ]
        sut.allocateForLargeVehicle()
        
        XCTAssertFalse(LocalStorage.shared.model.isEmpty, "Large slot is allocated when small & medium is unavailable for a small vehicle")
        XCTAssertEqual(LocalStorage.shared.floorId, 1)
        XCTAssertEqual(LocalStorage.shared.bayId, 4)
    }
    
    func testNoSlotsAvailable() {
        LocalStorage.shared.model = [
            ParkingLot(bayId: 1, floor: .first, size: .small, isAvailable: false),
            ParkingLot(bayId: 5, floor: .first, size: .large, isAvailable: false),
            ParkingLot(bayId: 2, floor: .first, size: .medium, isAvailable: false),
            ParkingLot(bayId: 6, floor: .first, size: .medium, isAvailable: false),
            ParkingLot(bayId: 3, floor: .first, size: .large, isAvailable: false),
            ParkingLot(bayId: 7, floor: .first, size: .large, isAvailable: false),
            ParkingLot(bayId: 4, floor: .first, size: .extraLarge, isAvailable: false),
            ParkingLot(bayId: 8, floor: .first, size: .extraLarge, isAvailable: false),
        ]
        
        sut.allocateForXLVehicle()
        
        XCTAssertFalse(LocalStorage.shared.model.isEmpty, "Large slot is allocated when small & medium is unavailable for a small vehicle")
        XCTAssertEqual(LocalStorage.shared.floorId, 0)
        XCTAssertEqual(LocalStorage.shared.bayId, 0)
    }
}
