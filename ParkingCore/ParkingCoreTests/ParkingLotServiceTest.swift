//
//  ParkingLotServiceTest.swift
//  ParkingCoreTests
//
//  Created by Ronak Malick on 05/02/24.
//

import XCTest
@testable import ParkingCore

final class ParkingLotServiceTest: XCTestCase {
    var sut: ParkingLotService!
    
    override func setUp() {
        super.setUp()
        sut = ParkingLotService()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testFreeSlots() {
        sut.parkingArray = [ParkingLot(bayId: 1, floor: .first, size: .small, isAvailable: false)]
        sut.freeSlots(for: 1)
        XCTAssertTrue(sut.parkingArray[0].isAvailable, "Slot should be available after freeing")
    }
    
    func testGetSlotsForSmallVehicle() {
        sut.setupParkingLotSpace(floors: 1, small: 2, medium: 2, large: 2, xL: 2)
        let slots = sut.getSlots(size: .small)
        XCTAssertNotNil(slots, "Slots should not be nil")
        XCTAssertTrue(slots.floorId == 1 && slots.bayId > 0, "Incorrect slots allocated for a small vehicle")
    }
    
    func testGetSlotsForMediumVehicle() {
        sut.setupParkingLotSpace(floors: 1, small: 2, medium: 2, large: 2, xL: 2)
        let slots = sut.getSlots(size: .medium)
        XCTAssertNotNil(slots, "Slots should not be nil")
        XCTAssertTrue(slots.floorId == 1 && slots.bayId > 0, "Incorrect slots allocated for a small vehicle")
    }
    
    func testGetSlotsForLargeVehicle() {
        sut.setupParkingLotSpace(floors: 1, small: 2, medium: 2, large: 2, xL: 2)
        let slots = sut.getSlots(size: .large)
        XCTAssertNotNil(slots, "Slots should not be nil")
        XCTAssertTrue(slots.floorId == 1 && slots.bayId > 0, "Incorrect slots allocated for a small vehicle")
    }
    
    func testGetSlotsForXLVehicle() {
        sut.setupParkingLotSpace(floors: 1, small: 2, medium: 2, large: 2, xL: 2)
        let slots = sut.getSlots(size: .extraLarge)
        XCTAssertNotNil(slots, "Slots should not be nil")
        XCTAssertTrue(slots.floorId == 1 && slots.bayId > 0, "Incorrect slots allocated for a small vehicle")
    }
    
    func testAllocateForSmallVehicleIntoMediumWhenUnavailable() {
        sut.parkingArray = [
            ParkingLot(bayId: 1, floor: .first, size: .small, isAvailable: false),
            ParkingLot(bayId: 5, floor: .first, size: .small, isAvailable: false),
            ParkingLot(bayId: 2, floor: .first, size: .medium, isAvailable: true)
        ]
        sut.allocateForSmallVehicle()
        
        XCTAssertFalse(sut.parkingArray.isEmpty, "Medium slot is allocated when small is unavailable for a small vehicle")
        XCTAssertEqual(sut.floorId, 1)
        XCTAssertEqual(sut.bayId, 2)
    }
    
    func testAllocateForSmallVehicleIntoLargeWhenUnavailable() {
        sut.parkingArray = [
            ParkingLot(bayId: 1, floor: .first, size: .small, isAvailable: false),
            ParkingLot(bayId: 5, floor: .first, size: .small, isAvailable: false),
            ParkingLot(bayId: 2, floor: .first, size: .medium, isAvailable: false),
            ParkingLot(bayId: 6, floor: .first, size: .medium, isAvailable: false),
            ParkingLot(bayId: 3, floor: .first, size: .large, isAvailable: true)
        ]
        sut.allocateForSmallVehicle()
        
        XCTAssertFalse(sut.parkingArray.isEmpty, "Large slot is allocated when small & medium is unavailable for a small vehicle")
        XCTAssertEqual(sut.floorId, 1)
        XCTAssertEqual(sut.bayId, 3)
    }
    
    func testAllocateForSmallVehicleIntoXLWhenUnavailable() {
        sut.parkingArray = [
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
        
        XCTAssertFalse(sut.parkingArray.isEmpty, "XL slot is allocated when small & medium & large is unavailable for a small vehicle")
        XCTAssertEqual(sut.floorId, 1)
        XCTAssertEqual(sut.bayId, 4)
    }
    
    func testAllocateForMediumVehicleIntoLargeWhenUnavailable() {
        sut.parkingArray = [
            ParkingLot(bayId: 2, floor: .first, size: .medium, isAvailable: false),
            ParkingLot(bayId: 6, floor: .first, size: .medium, isAvailable: false),
            ParkingLot(bayId: 3, floor: .first, size: .large, isAvailable: true)
        ]
        sut.allocateForMediumVehicle()
        
        XCTAssertFalse(sut.parkingArray.isEmpty, "Large slot is allocated when small & medium is unavailable for a small vehicle")
        XCTAssertEqual(sut.floorId, 1)
        XCTAssertEqual(sut.bayId, 3)
    }
    
    func testAllocateForMediumVehicleIntoXLWhenUnavailable() {
        sut.parkingArray = [
            ParkingLot(bayId: 2, floor: .first, size: .medium, isAvailable: false),
            ParkingLot(bayId: 6, floor: .first, size: .medium, isAvailable: false),
            ParkingLot(bayId: 4, floor: .first, size: .extraLarge, isAvailable: true)
        ]
        sut.allocateForMediumVehicle()
        
        XCTAssertFalse(sut.parkingArray.isEmpty, "Large slot is allocated when small & medium is unavailable for a small vehicle")
        XCTAssertEqual(sut.floorId, 1)
        XCTAssertEqual(sut.bayId, 4)
    }
    
    func testAllocateForLargeVehicleIntoXLWhenUnavailable() {
        sut.parkingArray = [
            ParkingLot(bayId: 3, floor: .first, size: .large, isAvailable: false),
            ParkingLot(bayId: 7, floor: .first, size: .large, isAvailable: false),
            ParkingLot(bayId: 4, floor: .first, size: .extraLarge, isAvailable: true)
        ]
        sut.allocateForLargeVehicle()
        
        XCTAssertFalse(sut.parkingArray.isEmpty, "Large slot is allocated when small & medium is unavailable for a small vehicle")
        XCTAssertEqual(sut.floorId, 1)
        XCTAssertEqual(sut.bayId, 4)
    }
    
    func testNoSlotsAvailable() {
        sut.parkingArray = [
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
        
        XCTAssertFalse(sut.parkingArray.isEmpty, "Large slot is allocated when small & medium is unavailable for a small vehicle")
        XCTAssertEqual(sut.floorId, 0)
        XCTAssertEqual(sut.bayId, 0)
    }
    
    func testSetupParkingLotSpace() {
        let floors = 1
        let small = 2
        let medium = 2
        let large = 2
        let xL = 2
        sut.setupParkingLotSpace(floors: floors, small: small, medium: medium, large: large, xL: xL)
        
        XCTAssertEqual(sut.parkingArray.count, floors * (small + medium + large + xL), "Incorrect total number of parking lots")
    }
    
    func testSetupParkingLotSpace_Allocation_SingleFloor() {
        let floors = 1
        let small = 2
        let medium = 2
        let large = 2
        let xL = 2

        sut.setupParkingLotSpace(floors: floors, small: small, medium: medium, large: large, xL: xL)
        
        XCTAssertTrue(sut.parkingArray[0].bayId == 1)
        XCTAssertTrue(sut.parkingArray[1].bayId == 2)
        XCTAssertTrue(sut.parkingArray[2].bayId == 3)
        XCTAssertTrue(sut.parkingArray[3].bayId == 4)
        XCTAssertTrue(sut.parkingArray[4].bayId == 5)
        XCTAssertTrue(sut.parkingArray[5].bayId == 6)
        XCTAssertTrue(sut.parkingArray[6].bayId == 7)
        XCTAssertTrue(sut.parkingArray[7].bayId == 8)

        XCTAssertTrue(sut.parkingArray[0].size == .small)
        XCTAssertTrue(sut.parkingArray[1].size == .medium)
        XCTAssertTrue(sut.parkingArray[2].size == .large)
        XCTAssertTrue(sut.parkingArray[3].size == .extraLarge)
        XCTAssertTrue(sut.parkingArray[4].size == .small)
        XCTAssertTrue(sut.parkingArray[5].size == .medium)
        XCTAssertTrue(sut.parkingArray[6].size == .large)
        XCTAssertTrue(sut.parkingArray[7].size == .extraLarge)

    }
    
    func testSetupParkingLotSpace_Allocation_MultipleFloor() {
        let floors = 2
        let small = 2
        let medium = 2
        let large = 2
        let xL = 2

        sut.setupParkingLotSpace(floors: floors, small: small, medium: medium, large: large, xL: xL)
        
        XCTAssertTrue(sut.parkingArray[0].bayId == 1)
        XCTAssertTrue(sut.parkingArray[1].bayId == 2)
        XCTAssertTrue(sut.parkingArray[2].bayId == 3)
        XCTAssertTrue(sut.parkingArray[3].bayId == 4)
        XCTAssertTrue(sut.parkingArray[4].bayId == 5)
        XCTAssertTrue(sut.parkingArray[5].bayId == 6)
        XCTAssertTrue(sut.parkingArray[6].bayId == 7)
        XCTAssertTrue(sut.parkingArray[7].bayId == 8)
        XCTAssertTrue(sut.parkingArray[8].bayId == 9)
        XCTAssertTrue(sut.parkingArray[9].bayId == 10)
        XCTAssertTrue(sut.parkingArray[10].bayId == 11)
        XCTAssertTrue(sut.parkingArray[11].bayId == 12)
        XCTAssertTrue(sut.parkingArray[12].bayId == 13)
        XCTAssertTrue(sut.parkingArray[13].bayId == 14)
        XCTAssertTrue(sut.parkingArray[14].bayId == 15)
        XCTAssertTrue(sut.parkingArray[15].bayId == 16)

        XCTAssertTrue(sut.parkingArray[0].size == .small)
        XCTAssertTrue(sut.parkingArray[1].size == .medium)
        XCTAssertTrue(sut.parkingArray[2].size == .large)
        XCTAssertTrue(sut.parkingArray[3].size == .extraLarge)
        XCTAssertTrue(sut.parkingArray[4].size == .small)
        XCTAssertTrue(sut.parkingArray[5].size == .medium)
        XCTAssertTrue(sut.parkingArray[6].size == .large)
        XCTAssertTrue(sut.parkingArray[7].size == .extraLarge)
        XCTAssertTrue(sut.parkingArray[8].size == .small)
        XCTAssertTrue(sut.parkingArray[9].size == .medium)
        XCTAssertTrue(sut.parkingArray[10].size == .large)
        XCTAssertTrue(sut.parkingArray[11].size == .extraLarge)
        XCTAssertTrue(sut.parkingArray[12].size == .small)
        XCTAssertTrue(sut.parkingArray[13].size == .medium)
        XCTAssertTrue(sut.parkingArray[14].size == .large)
        XCTAssertTrue(sut.parkingArray[15].size == .extraLarge)
        
        XCTAssertTrue(sut.parkingArray[0].floor == .first)
        XCTAssertTrue(sut.parkingArray[1].floor == .first)
        XCTAssertTrue(sut.parkingArray[2].floor == .first)
        XCTAssertTrue(sut.parkingArray[3].floor == .first)
        XCTAssertTrue(sut.parkingArray[4].floor == .first)
        XCTAssertTrue(sut.parkingArray[5].floor == .first)
        XCTAssertTrue(sut.parkingArray[6].floor == .first)
        XCTAssertTrue(sut.parkingArray[7].floor == .first)
        XCTAssertTrue(sut.parkingArray[8].floor == .second)
        XCTAssertTrue(sut.parkingArray[9].floor == .second)
        XCTAssertTrue(sut.parkingArray[10].floor == .second)
        XCTAssertTrue(sut.parkingArray[11].floor == .second)
        XCTAssertTrue(sut.parkingArray[12].floor == .second)
        XCTAssertTrue(sut.parkingArray[13].floor == .second)
        XCTAssertTrue(sut.parkingArray[14].floor == .second)
        XCTAssertTrue(sut.parkingArray[15].floor == .second)

    }
}
