//
//  ParkingLotServiceProtocol.swift
//  ParkingCore
//
//  Created by Ronak Malick on 04/02/24.
//

import Foundation

public protocol ParkingLotServiceProtocol {
    func getSlots(size: VehicleSize) -> (floorId: Int, bayId: Int)
    func freeSlots(for bayId: Int)
    func setupParkingLotSpace(floors: Int,
                              small: Int,
                              medium: Int,
                              large: Int,
                              xL: Int)
}
