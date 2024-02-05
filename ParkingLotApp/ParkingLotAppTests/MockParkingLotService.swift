//
//  MockParkingLotService.swift
//  ParkingLotAppTests
//
//  Created by Ronak Malick on 06/02/24.
//

import Foundation
import ParkingCore

class MockParkingLotService: ParkingLotServiceProtocol {
    var setupParkingLotSpaceCount = 0
    
    func setupParkingLotSpace(floors: Int,
                              small: Int,
                              medium: Int,
                              large: Int,
                              xL: Int) {
        setupParkingLotSpaceCount += 1
    }
}
