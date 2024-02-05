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
        LocalStorage.shared.clearAll()
        sut = ParkingLotService()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testSetupParkingLotSpace() {
        let floors = 1
        let small = 2
        let medium = 2
        let large = 2
        let xL = 2
        sut.setupParkingLotSpace(floors: floors, small: small, medium: medium, large: large, xL: xL)
        
        XCTAssertEqual(LocalStorage.shared.model.count,
                       floors * (small + medium + large + xL), "Incorrect total number of parking lots")
    }
    
    func testSetupParkingLotSpace_Allocation_SingleFloor() {
        let floors = 1
        let small = 2
        let medium = 2
        let large = 2
        let xL = 2

        sut.setupParkingLotSpace(floors: floors, small: small, medium: medium, large: large, xL: xL)
        
        XCTAssertTrue(LocalStorage.shared.model[0].bayId == 1)
        XCTAssertTrue(LocalStorage.shared.model[1].bayId == 2)
        XCTAssertTrue(LocalStorage.shared.model[2].bayId == 3)
        XCTAssertTrue(LocalStorage.shared.model[3].bayId == 4)
        XCTAssertTrue(LocalStorage.shared.model[4].bayId == 5)
        XCTAssertTrue(LocalStorage.shared.model[5].bayId == 6)
        XCTAssertTrue(LocalStorage.shared.model[6].bayId == 7)
        XCTAssertTrue(LocalStorage.shared.model[7].bayId == 8)

        XCTAssertTrue(LocalStorage.shared.model[0].size == .small)
        XCTAssertTrue(LocalStorage.shared.model[1].size == .medium)
        XCTAssertTrue(LocalStorage.shared.model[2].size == .large)
        XCTAssertTrue(LocalStorage.shared.model[3].size == .extraLarge)
        XCTAssertTrue(LocalStorage.shared.model[4].size == .small)
        XCTAssertTrue(LocalStorage.shared.model[5].size == .medium)
        XCTAssertTrue(LocalStorage.shared.model[6].size == .large)
        XCTAssertTrue(LocalStorage.shared.model[7].size == .extraLarge)

    }
    
    func testSetupParkingLotSpace_Allocation_MultipleFloor() {
        let floors = 2
        let small = 2
        let medium = 2
        let large = 2
        let xL = 2

        sut.setupParkingLotSpace(floors: floors, small: small, medium: medium, large: large, xL: xL)
        
        XCTAssertTrue(LocalStorage.shared.model[0].bayId == 1)
        XCTAssertTrue(LocalStorage.shared.model[1].bayId == 2)
        XCTAssertTrue(LocalStorage.shared.model[2].bayId == 3)
        XCTAssertTrue(LocalStorage.shared.model[3].bayId == 4)
        XCTAssertTrue(LocalStorage.shared.model[4].bayId == 5)
        XCTAssertTrue(LocalStorage.shared.model[5].bayId == 6)
        XCTAssertTrue(LocalStorage.shared.model[6].bayId == 7)
        XCTAssertTrue(LocalStorage.shared.model[7].bayId == 8)
        XCTAssertTrue(LocalStorage.shared.model[8].bayId == 9)
        XCTAssertTrue(LocalStorage.shared.model[9].bayId == 10)
        XCTAssertTrue(LocalStorage.shared.model[10].bayId == 11)
        XCTAssertTrue(LocalStorage.shared.model[11].bayId == 12)
        XCTAssertTrue(LocalStorage.shared.model[12].bayId == 13)
        XCTAssertTrue(LocalStorage.shared.model[13].bayId == 14)
        XCTAssertTrue(LocalStorage.shared.model[14].bayId == 15)
        XCTAssertTrue(LocalStorage.shared.model[15].bayId == 16)

        XCTAssertTrue(LocalStorage.shared.model[0].size == .small)
        XCTAssertTrue(LocalStorage.shared.model[1].size == .medium)
        XCTAssertTrue(LocalStorage.shared.model[2].size == .large)
        XCTAssertTrue(LocalStorage.shared.model[3].size == .extraLarge)
        XCTAssertTrue(LocalStorage.shared.model[4].size == .small)
        XCTAssertTrue(LocalStorage.shared.model[5].size == .medium)
        XCTAssertTrue(LocalStorage.shared.model[6].size == .large)
        XCTAssertTrue(LocalStorage.shared.model[7].size == .extraLarge)
        XCTAssertTrue(LocalStorage.shared.model[8].size == .small)
        XCTAssertTrue(LocalStorage.shared.model[9].size == .medium)
        XCTAssertTrue(LocalStorage.shared.model[10].size == .large)
        XCTAssertTrue(LocalStorage.shared.model[11].size == .extraLarge)
        XCTAssertTrue(LocalStorage.shared.model[12].size == .small)
        XCTAssertTrue(LocalStorage.shared.model[13].size == .medium)
        XCTAssertTrue(LocalStorage.shared.model[14].size == .large)
        XCTAssertTrue(LocalStorage.shared.model[15].size == .extraLarge)
        
        XCTAssertTrue(LocalStorage.shared.model[0].floor == .first)
        XCTAssertTrue(LocalStorage.shared.model[1].floor == .first)
        XCTAssertTrue(LocalStorage.shared.model[2].floor == .first)
        XCTAssertTrue(LocalStorage.shared.model[3].floor == .first)
        XCTAssertTrue(LocalStorage.shared.model[4].floor == .first)
        XCTAssertTrue(LocalStorage.shared.model[5].floor == .first)
        XCTAssertTrue(LocalStorage.shared.model[6].floor == .first)
        XCTAssertTrue(LocalStorage.shared.model[7].floor == .first)
        XCTAssertTrue(LocalStorage.shared.model[8].floor == .second)
        XCTAssertTrue(LocalStorage.shared.model[9].floor == .second)
        XCTAssertTrue(LocalStorage.shared.model[10].floor == .second)
        XCTAssertTrue(LocalStorage.shared.model[11].floor == .second)
        XCTAssertTrue(LocalStorage.shared.model[12].floor == .second)
        XCTAssertTrue(LocalStorage.shared.model[13].floor == .second)
        XCTAssertTrue(LocalStorage.shared.model[14].floor == .second)
        XCTAssertTrue(LocalStorage.shared.model[15].floor == .second)

    }
}
