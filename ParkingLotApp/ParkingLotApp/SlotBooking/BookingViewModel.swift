//
//  BookingViewModel.swift
//  ParkingLotApp
//
//  Created by Ronak Malick on 05/02/24.
//

import Foundation
import ParkingCore

class BookingViewModel {
    private let service: ParkingLotServiceProtocol
    
    init(service: ParkingLotServiceProtocol) {
        self.service = service
    }
    
    func getSlotsForVehicleType(_ type: VehicleType,
                                onCompletion: (String) -> Void) {
        let slotNumber = service.getSlots(size: type)
        if slotNumber.floorId == 0 && slotNumber.bayId == 0 {
            onCompletion("NO SLOTS FOUND")
        } else {
            let ticket = "[" + String(slotNumber.floorId) + ":" + String(slotNumber.bayId) + "]"
            onCompletion(ticket)
        }
    }
    
    func freeSlotWithBayID(_ bayId: Int,
                           onCompletion: (Bool) -> Void) {
        service.freeSlots(for: bayId)
        onCompletion(true)
    }
}
