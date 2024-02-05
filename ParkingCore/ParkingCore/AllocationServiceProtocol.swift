//
//  AllocationServiceProtocol.swift
//  ParkingCore
//
//  Created by Ronak Malick on 06/02/24.
//

import Foundation

public protocol AllocationServiceProtocol {
    func getSlots(size: VehicleType) -> (floorId: Int, bayId: Int)
}
