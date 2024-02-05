//
//  ParkingLotService.swift
//  ParkingCore
//
//  Created by Ronak Malick on 04/02/24.
//

import Foundation

public class ParkingLotService: ParkingLotServiceProtocol {
    private let maxVehicleType = 4
    
    public init() {}
    
    public func setupParkingLotSpace(floors: Int,
                                     small: Int,
                                     medium: Int,
                                     large: Int,
                                     xL: Int) {
        let maxSize = floors * (small + medium + large + xL)
        
        for id in 1...maxSize {
            if id % maxVehicleType == 0 {
                if id <= (xL * maxVehicleType) {
                    LocalStorage.shared.saveInStorage(slot: ParkingLot(bayId: id, floor: .first, size: .extraLarge, isAvailable: true))
                }
                if id > xL * maxVehicleType && id <= 2 * (xL * maxVehicleType) {
                    LocalStorage.shared.saveInStorage(slot: (ParkingLot(bayId: id, floor: .second, size: .extraLarge, isAvailable: true)))
                }
                if id > 2 * (xL * maxVehicleType) {
                    LocalStorage.shared.saveInStorage(slot: (ParkingLot(bayId: id, floor: .third, size: .extraLarge, isAvailable: true)))
                }
            }
            
            if id % maxVehicleType == 1 {
                if id <= (small * maxVehicleType) {
                    LocalStorage.shared.saveInStorage(slot: (ParkingLot(bayId: id, floor: .first, size: .small, isAvailable: true)))
                }
                if id > small * maxVehicleType && id <= 2 * (small * maxVehicleType) {
                    LocalStorage.shared.saveInStorage(slot: (ParkingLot(bayId: id, floor: .second, size: .small, isAvailable: true)))
                }
                if id > 2 * (small * maxVehicleType) {
                    LocalStorage.shared.saveInStorage(slot: (ParkingLot(bayId: id, floor: .third, size: .small, isAvailable: true)))
                }
            }
            
            if id % maxVehicleType == 2 {
                if id <= (medium * maxVehicleType) {
                    LocalStorage.shared.saveInStorage(slot: (ParkingLot(bayId: id, floor: .first, size: .medium, isAvailable: true)))
                }
                if id > medium * maxVehicleType && id <= 2 * (medium * maxVehicleType) {
                    LocalStorage.shared.saveInStorage(slot: (ParkingLot(bayId: id, floor: .second, size: .medium, isAvailable: true)))
                }
                if id > 2 * (medium * maxVehicleType) {
                    LocalStorage.shared.saveInStorage(slot: (ParkingLot(bayId: id, floor: .third, size: .medium, isAvailable: true)))
                }
            }
            
            if id % maxVehicleType == 3 {
                if id <= (large * maxVehicleType) {
                    LocalStorage.shared.saveInStorage(slot: (ParkingLot(bayId: id, floor: .first, size: .large, isAvailable: true)))
                }
                if id > large * maxVehicleType && id <= 2 * (large * maxVehicleType) {
                    LocalStorage.shared.saveInStorage(slot: (ParkingLot(bayId: id, floor: .second, size: .large, isAvailable: true)))
                }
                if id > 2 * (large * maxVehicleType) {
                    LocalStorage.shared.saveInStorage(slot: (ParkingLot(bayId: id, floor: .third, size: .large, isAvailable: true)))
                }
            }
        }
    }
}
