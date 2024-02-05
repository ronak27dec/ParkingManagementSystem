//
//  FreeupServiceTest.swift
//  ParkingCoreTests
//
//  Created by Ronak Malick on 06/02/24.
//

import XCTest
@testable import ParkingCore

final class FreeupServiceTest: XCTestCase {

    private var sut: FreeUpService!
    
    override func setUp() {
        super.setUp()
        sut = FreeUpService()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testFreeSlots() {
        LocalStorage.shared.model = [ParkingLot(bayId: 1, floor: .first, size: .small, isAvailable: false)]
        sut.freeSlots(for: 1)
        XCTAssertTrue(LocalStorage.shared.model[0].isAvailable, "Slot should be available after freeing")
    }
}
