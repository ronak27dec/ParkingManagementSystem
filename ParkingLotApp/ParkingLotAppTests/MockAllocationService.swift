//
//  MockAllocationService.swift
//  ParkingLotAppTests
//
//  Created by Ronak Malick on 06/02/24.
//

import Foundation
import ParkingCore

class MockAllocationService: AllocationServiceProtocol {
    var getSlotsCalledCount = 0
    var floorId = 1
    var bayId = 1

    func getSlots(size: ParkingCore.VehicleType) -> (floorId: Int, bayId: Int) {
        getSlotsCalledCount += 1
        return (floorId, bayId)
    }
}
