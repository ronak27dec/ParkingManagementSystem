//
//  AllocationProtocol.swift
//  ParkingCore
//
//  Created by Ronak Malick on 04/02/24.
//

import Foundation

public protocol AllocationProtocol {
    func allocate(size: ParkingSlotSize) -> (floorId: Int, bayId: Int)
    func deallocateSpace(for bayId: Int)
    func setup(floors: Int,
               small: Int,
               medium: Int,
               large: Int,
               xL: Int)
}
