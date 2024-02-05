//
//  ParkingLotServiceProtocol.swift
//  ParkingCore
//
//  Created by Ronak Malick on 04/02/24.
//

import Foundation

public protocol ParkingLotServiceProtocol {
    func setupParkingLotSpace(floors: Int,
                              small: Int,
                              medium: Int,
                              large: Int,
                              xL: Int)
}
