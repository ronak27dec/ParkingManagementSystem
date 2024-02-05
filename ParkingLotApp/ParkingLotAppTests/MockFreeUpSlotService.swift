//
//  MockFreeUpSlotService.swift
//  ParkingLotAppTests
//
//  Created by Ronak Malick on 06/02/24.
//

import Foundation
import ParkingCore

class MockFreeUpSlotService: FreeUpSlotServiceProtocol {
    var freeSlotsCalledCount = 0

    func freeSlots(for bayId: Int) {
        freeSlotsCalledCount += 1
    }
}
