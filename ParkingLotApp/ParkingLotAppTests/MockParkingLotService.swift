//
//  MockParkingLotService.swift
//  ParkingLotAppTests
//
//  Created by Ronak Malick on 06/02/24.
//

import Foundation
import ParkingCore

class MockParkingLotService: ParkingLotServiceProtocol {
    var getSlotsCalledCount = 0
    var freeSlotsCalledCount = 0
    var setupParkingLotSpaceCount = 0
    var floorId = 1
    var bayId = 1
    
    func getSlots(size: ParkingCore.VehicleType) -> (floorId: Int, bayId: Int) {
        getSlotsCalledCount += 1
        return (floorId, bayId)
    }
    
    func freeSlots(for bayId: Int) {
        freeSlotsCalledCount += 1
    }
    
    func setupParkingLotSpace(floors: Int, small: Int, medium: Int, large: Int, xL: Int) {
        setupParkingLotSpaceCount += 1
    }
}
