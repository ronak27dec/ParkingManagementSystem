//
//  FreeUpService.swift
//  ParkingCore
//
//  Created by Ronak Malick on 06/02/24.
//

import Foundation

public class FreeUpService: FreeUpSlotServiceProtocol {
    
    public init() {}

    public func freeSlots(for bayId: Int) {
        LocalStorage.shared.updateStorage(for: bayId, isAvailable: true)
    }
}
