//
//  ParkingLotService.swift
//  ParkingCore
//
//  Created by Ronak Malick on 04/02/24.
//

import Foundation

public class ParkingLotService: ParkingLotServiceProtocol {
    var parkingArray: [ParkingLot] = []
    var floorId = 0
    var bayId = 0
    private let maxVehicleType = 4
    
    private var isSlotAvailableForSmallVehicle: Bool {
        let isAvailable = parkingArray.filter { $0.isAvailable == true && $0.size == .small }
        return isAvailable.count == 0 ? false : true
    }
    
    private var isSlotAvailableForMediumVehicle: Bool {
        let isAvailable = parkingArray.filter { $0.isAvailable == true && $0.size == .medium }
        return isAvailable.count == 0 ? false : true
    }
    
    private var isSlotAvailableForLargeVehicle: Bool {
        let isAvailable = parkingArray.filter { $0.isAvailable == true && $0.size == .large }
        return isAvailable.count == 0 ? false : true
    }
    
    private var isSlotAvailableForXLVehicle: Bool {
        let isAvailable = parkingArray.filter { $0.isAvailable == true && $0.size == .extraLarge }
        return isAvailable.count == 0 ? false : true
    }
    
    public init() {
    }
    
    public func freeSlots(for bayId: Int) {
        update(bayId: bayId, newAvailability: true)
    }
    
    public func getSlots(size: VehicleType) -> (floorId: Int, bayId: Int) {
        allocateSpace(for: size)
        return (self.floorId, self.bayId)
    }
    
    
    func allocateForSmallVehicle() {
        if isSlotAvailableForSmallVehicle {
            let slots = getAvailableSpaces(for: .small)
            update(bayId: slots[0].bayId, newAvailability: false)
        } else if isSlotAvailableForMediumVehicle {
            let slots = getAvailableSpaces(for: .medium)
            update(bayId: slots[0].bayId, newAvailability: false)
        } else if isSlotAvailableForLargeVehicle {
            let slots = getAvailableSpaces(for: .large)
            update(bayId: slots[0].bayId, newAvailability: false)
        } else {
            let slots = getAvailableSpaces(for: .extraLarge)
            if slots.count > 0 {
                update(bayId: slots[0].bayId, newAvailability: false)
            } else {
                self.floorId = 0
                self.bayId = 0
            }
        }
    }
    
    func allocateForMediumVehicle() {
        if isSlotAvailableForMediumVehicle {
            let slots = getAvailableSpaces(for: .medium)
            update(bayId: slots[0].bayId, newAvailability: false)
        } else if isSlotAvailableForLargeVehicle {
            let slots = getAvailableSpaces(for: .large)
            update(bayId: slots[0].bayId, newAvailability: false)
        } else {
            let slots = getAvailableSpaces(for: .extraLarge)
            if slots.count > 0 {
                update(bayId: slots[0].bayId, newAvailability: false)
            } else {
                self.floorId = 0
                self.bayId = 0            }
        }
    }
    
    func allocateForLargeVehicle() {
        if isSlotAvailableForLargeVehicle {
            let slots = getAvailableSpaces(for: .large)
            update(bayId: slots[0].bayId, newAvailability: false)
        } else {
            let slots = getAvailableSpaces(for: .extraLarge)
            if slots.count > 0 {
                update(bayId: slots[0].bayId, newAvailability: false)
            } else {
                self.floorId = 0
                self.bayId = 0            }
        }
    }
    
    func allocateForXLVehicle() {
        if isSlotAvailableForXLVehicle {
            let slots = getAvailableSpaces(for: .extraLarge)
            if slots.count > 0 {
                update(bayId: slots[0].bayId, newAvailability: false)
            } else {
                self.floorId = 0
                self.bayId = 0            }
        } else {
            self.floorId = 0
            self.bayId = 0 
            print("No Space Available")
        }
    }
    
    private func update(bayId: Int, newAvailability: Bool) {
        if let index = parkingArray.firstIndex(where: { $0.bayId == bayId }) {
            self.floorId = parkingArray[index].floor.rawValue
            self.bayId = parkingArray[index].bayId
            parkingArray[index].isAvailable = newAvailability
        } else {
            
            print("Element with Bay ID \(bayId) not found.")
        }
    }
    
    private func getAvailableSpaces(for size: VehicleType) -> [ParkingLot] {
        let slots = parkingArray.filter { $0.isAvailable && $0.size == size }
        return slots
    }
    
    private func allocateSpace(for size: VehicleType) {
        switch size {
        case .small: allocateForSmallVehicle()
        case .medium: allocateForMediumVehicle()
        case .large: allocateForLargeVehicle()
        case .extraLarge: allocateForXLVehicle()
        }
    }
    
    public func setupParkingLotSpace(floors: Int,
                                     small: Int,
                                     medium: Int,
                                     large: Int,
                                     xL: Int) {
        parkingArray = []
        let maxSize = floors * (small + medium + large + xL)
        
        for id in 1...maxSize {
            if id % maxVehicleType == 0 {
                if id <= (xL * maxVehicleType) {
                    parkingArray.append(ParkingLot(bayId: id, floor: .first, size: .extraLarge, isAvailable: true))
                }
                if id > xL * maxVehicleType && id <= 2 * (xL * maxVehicleType) {
                    parkingArray.append(ParkingLot(bayId: id, floor: .second, size: .extraLarge, isAvailable: true))
                }
                if id > 2 * (xL * maxVehicleType) {
                    parkingArray.append(ParkingLot(bayId: id, floor: .third, size: .extraLarge, isAvailable: true))
                }
            }
            
            if id % maxVehicleType == 1 {
                if id <= (small * maxVehicleType) {
                    parkingArray.append(ParkingLot(bayId: id, floor: .first, size: .small, isAvailable: true))
                }
                if id > small * maxVehicleType && id <= 2 * (small * maxVehicleType) {
                    parkingArray.append(ParkingLot(bayId: id, floor: .second, size: .small, isAvailable: true))
                }
                if id > 2 * (small * maxVehicleType) {
                    parkingArray.append(ParkingLot(bayId: id, floor: .third, size: .small, isAvailable: true))
                }
            }
            
            if id % maxVehicleType == 2 {
                if id <= (medium * maxVehicleType) {
                    parkingArray.append(ParkingLot(bayId: id, floor: .first, size: .medium, isAvailable: true))
                }
                if id > medium * maxVehicleType && id <= 2 * (medium * maxVehicleType) {
                    parkingArray.append(ParkingLot(bayId: id, floor: .second, size: .medium, isAvailable: true))
                }
                if id > 2 * (medium * maxVehicleType) {
                    parkingArray.append(ParkingLot(bayId: id, floor: .third, size: .medium, isAvailable: true))
                }
            }
            
            if id % maxVehicleType == 3 {
                if id <= (large * maxVehicleType) {
                    parkingArray.append(ParkingLot(bayId: id, floor: .first, size: .large, isAvailable: true))
                }
                if id > large * maxVehicleType && id <= 2 * (large * maxVehicleType) {
                    parkingArray.append(ParkingLot(bayId: id, floor: .second, size: .large, isAvailable: true))
                }
                if id > 2 * (large * maxVehicleType) {
                    parkingArray.append(ParkingLot(bayId: id, floor: .third, size: .large, isAvailable: true))
                }
            }
        }
    }
}
