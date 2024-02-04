//
//  Allocate.swift
//  ParkingCore
//
//  Created by Ronak Malick on 04/02/24.
//

import Foundation

struct ParkingLot {
    var bayId: Int
    var floor: Floor
    var size: ParkingSlotSize
    var isAvailable: Bool
}

enum Floor: Int {
    case first = 1
    case second = 2
    case third = 3
}

public class Allocate: AllocationProtocol {
    var parkingArray: [ParkingLot] = []
    private var floorId = 0
    private var bayId = 0
    
    public init() {
    }
    
    public func deallocateSpace(for bayId: Int) {
        update(bayId: bayId, newAvailability: true)
        
        print(parkingArray)
    }
    
    public func allocate(size: ParkingSlotSize) -> (floorId: Int, bayId: Int) {
        allocateSpace(for: size)
        
        print("Ticket Number: \(self.floorId) + \(self.bayId)")
        return (self.floorId, self.bayId)
    }
    
    
    func allocateForSmallVehicle() {
        if isSpaceAvailableForSmallVehicle {
            let slots = getAvailableSpaces(for: .small)
            update(bayId: slots[0].bayId, newAvailability: false)
        } else if isSpaceAvailableForMediumVehicle {
            let slots = getAvailableSpaces(for: .medium)
            update(bayId: slots[0].bayId, newAvailability: false)
        } else if isSpaceAvailableForMediumVehicle {
            let slots = getAvailableSpaces(for: .large)
            update(bayId: slots[0].bayId, newAvailability: false)
        } else {
            let slots = getAvailableSpaces(for: .extraLarge)
            update(bayId: slots[0].bayId, newAvailability: false)
        }        
    }
    
    func allocateForMediumVehicle() {
        if isSpaceAvailableForMediumVehicle {
            let slots = getAvailableSpaces(for: .medium)
            update(bayId: slots[0].bayId, newAvailability: false)
        } else if isSpaceAvailableForMediumVehicle {
            let slots = getAvailableSpaces(for: .large)
            update(bayId: slots[0].bayId, newAvailability: false)
        } else {
            let slots = getAvailableSpaces(for: .extraLarge)
            update(bayId: slots[0].bayId, newAvailability: false)
        }
    }
    
    func allocateForLargeVehicle() {
        if isSpaceAvailableForMediumVehicle {
            let slots = getAvailableSpaces(for: .large)
            update(bayId: slots[0].bayId, newAvailability: false)
        } else {
            let slots = getAvailableSpaces(for: .extraLarge)
            update(bayId: slots[0].bayId, newAvailability: false)
        }
    }
    
    func allocateForXLVehicle() {
        if isSpaceAvailableForXLVehicle {
            let slots = getAvailableSpaces(for: .extraLarge)
            update(bayId: slots[0].bayId, newAvailability: false)
        } else {
            print("No Space Available")
        }
    }
    
    func update(bayId: Int, newAvailability: Bool) {
        if let index = parkingArray.firstIndex(where: { $0.bayId == bayId }) {
            self.floorId = parkingArray[index].floor.rawValue
            self.bayId = parkingArray[index].bayId
            parkingArray[index].isAvailable = newAvailability
        } else {
            print("Element with Bay ID \(bayId) not found.")
        }
    }
    func getAvailableSpaces(for size: ParkingSlotSize) -> [ParkingLot] {
        let slots = parkingArray.filter { $0.isAvailable && $0.size == size }
        return slots
    }

    var isSpaceAvailableForSmallVehicle: Bool {
        let isAvailable = parkingArray.filter { $0.isAvailable == true && $0.size == .small }
        return isAvailable.count == 0 ? false : true
    }

    var isSpaceAvailableForMediumVehicle: Bool {
        let isAvailable = parkingArray.filter { $0.isAvailable == true && $0.size == .medium }
        return isAvailable.count == 0 ? false : true
    }
    
    var isSpaceAvailableForLargeVehicle: Bool {
        let isAvailable = parkingArray.filter { $0.isAvailable == true && $0.size == .large }
        return isAvailable.count == 0 ? false : true
    }
    
    var isSpaceAvailableForXLVehicle: Bool {
        let isAvailable = parkingArray.filter { $0.isAvailable == true && $0.size == .extraLarge }
        return isAvailable.count == 0 ? false : true
    }
    
    func allocateSpace(for size: ParkingSlotSize) {
        switch size {
        case .small: allocateForSmallVehicle()
        case .medium: allocateForMediumVehicle()
        case .large: allocateForLargeVehicle()
        case .extraLarge: allocateForXLVehicle()
        }
    }
    
    public func setup(floors: Int,
                      small: Int,
                      medium: Int,
                      large: Int,
                      xL: Int) {
        
        let maxSize = floors * (small + medium + large + xL)
        
        for id in 1...maxSize {
            if id % 4 == 1 {
                if id <= (small * 4) {
                    parkingArray.append(ParkingLot(bayId: id, floor: .first, size: .small, isAvailable: true))
                }
                if id > small * 4 && id <= 2 * (small * 4) {
                    parkingArray.append(ParkingLot(bayId: id, floor: .second, size: .small, isAvailable: true))
                }
                if id > 2 * (small * 4) {
                    parkingArray.append(ParkingLot(bayId: id, floor: .third, size: .small, isAvailable: true))
                }
            }
            
            if id % 4 == 2 {
                if id <= (small * 4) {
                    parkingArray.append(ParkingLot(bayId: id, floor: .first, size: .medium, isAvailable: true))
                }
                if id > small * 4 && id <= 2 * (small * 4) {
                    parkingArray.append(ParkingLot(bayId: id, floor: .second, size: .medium, isAvailable: true))
                }
                if id > 2 * (small * 4) {
                    parkingArray.append(ParkingLot(bayId: id, floor: .third, size: .medium, isAvailable: true))
                }
            }
            
            if id % 4 == 3 {
                if id <= (small * 4) {
                    parkingArray.append(ParkingLot(bayId: id, floor: .first, size: .large, isAvailable: true))
                }
                if id > small * 4 && id <= 2 * (small * 4) {
                    parkingArray.append(ParkingLot(bayId: id, floor: .second, size: .large, isAvailable: true))
                }
                if id > 2 * (small * 4) {
                    parkingArray.append(ParkingLot(bayId: id, floor: .third, size: .large, isAvailable: true))
                }
            }
            
            if id % 4 == 0 {
                if id <= (small * 4) {
                    parkingArray.append(ParkingLot(bayId: id, floor: .first, size: .extraLarge, isAvailable: true))
                }
                if id > small * 4 && id <= 2 * (small * 4) {
                    parkingArray.append(ParkingLot(bayId: id, floor: .second, size: .extraLarge, isAvailable: true))
                }
                if id > 2 * (small * 4) {
                    parkingArray.append(ParkingLot(bayId: id, floor: .third, size: .extraLarge, isAvailable: true))
                }
            }
        }
    }
}
