//
//  Storable.swift
//  ParkingCore
//
//  Created by Ronak Malick on 06/02/24.
//

import Foundation

protocol Storable {
    func updateStorage(for bayId: Int, isAvailable: Bool)
    func saveInStorage(slot: ParkingLot)
    func clearAll()
}
