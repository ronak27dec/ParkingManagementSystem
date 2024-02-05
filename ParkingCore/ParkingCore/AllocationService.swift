//
//  AllocationService.swift
//  ParkingCore
//
//  Created by Ronak Malick on 06/02/24.
//

import Foundation

public class AllocationService: AllocationServiceProtocol {
    
    private var isSlotAvailableForSmallVehicle: Bool {
        let isAvailable = LocalStorage.shared.model.filter { $0.isAvailable == true && $0.size == .small }
        return isAvailable.count == 0 ? false : true
    }
    
    private var isSlotAvailableForMediumVehicle: Bool {
        let isAvailable = LocalStorage.shared.model.filter { $0.isAvailable == true && $0.size == .medium }
        return isAvailable.count == 0 ? false : true
    }
    
    private var isSlotAvailableForLargeVehicle: Bool {
        let isAvailable = LocalStorage.shared.model.filter { $0.isAvailable == true && $0.size == .large }
        return isAvailable.count == 0 ? false : true
    }
    
    private var isSlotAvailableForXLVehicle: Bool {
        let isAvailable = LocalStorage.shared.model.filter { $0.isAvailable == true && $0.size == .extraLarge }
        return isAvailable.count == 0 ? false : true
    }
    
    public init() {}
    
    public func getSlots(size: VehicleType) -> (floorId: Int, bayId: Int) {
        allocateSlots(for: size)
        return (LocalStorage.shared.floorId, LocalStorage.shared.bayId)
    }
    
    private func allocateSlots(for vehicleType: VehicleType) {
        switch vehicleType {
        case .small: allocateForSmallVehicle()
        case .medium: allocateForMediumVehicle()
        case .large: allocateForLargeVehicle()
        case .extraLarge: allocateForXLVehicle()
        }
    }
    
    private func getAvailableSpaces(for size: VehicleType) -> [ParkingLot] {
        let slots = LocalStorage.shared.model.filter { $0.isAvailable && $0.size == size }
        return slots
    }
    
    func allocateForSmallVehicle() {
        if isSlotAvailableForSmallVehicle {
            let slots = getAvailableSpaces(for: .small)
            
            LocalStorage.shared.updateStorage(for: slots[0].bayId, isAvailable: false)
            
        } else if isSlotAvailableForMediumVehicle {
            let slots = getAvailableSpaces(for: .medium)
            
            LocalStorage.shared.updateStorage(for: slots[0].bayId, isAvailable: false)
            
            
        } else if isSlotAvailableForLargeVehicle {
            let slots = getAvailableSpaces(for: .large)
            
            LocalStorage.shared.updateStorage(for: slots[0].bayId, isAvailable: false)
            
        } else {
            let slots = getAvailableSpaces(for: .extraLarge)
            if slots.count > 0 {
                LocalStorage.shared.updateStorage(for: slots[0].bayId, isAvailable: false)
            } else {
                LocalStorage.shared.floorId = 0
                LocalStorage.shared.bayId = 0
            }
        }
    }
    
    func allocateForMediumVehicle() {
        if isSlotAvailableForMediumVehicle {
            let slots = getAvailableSpaces(for: .medium)
            LocalStorage.shared.updateStorage(for: slots[0].bayId, isAvailable: false)
        } else if isSlotAvailableForLargeVehicle {
            let slots = getAvailableSpaces(for: .large)
            LocalStorage.shared.updateStorage(for: slots[0].bayId, isAvailable: false)
        } else {
            let slots = getAvailableSpaces(for: .extraLarge)
            if slots.count > 0 {
                LocalStorage.shared.updateStorage(for: slots[0].bayId, isAvailable: false)
            } else {
                LocalStorage.shared.floorId = 0
                LocalStorage.shared.bayId = 0
            }
        }
    }
    
    func allocateForLargeVehicle() {
        if isSlotAvailableForLargeVehicle {
            let slots = getAvailableSpaces(for: .large)
            LocalStorage.shared.updateStorage(for: slots[0].bayId, isAvailable: false)
        } else {
            let slots = getAvailableSpaces(for: .extraLarge)
            if slots.count > 0 {
                LocalStorage.shared.updateStorage(for: slots[0].bayId, isAvailable: false)
            } else {
                LocalStorage.shared.floorId = 0
                LocalStorage.shared.bayId = 0
            }
        }
    }
    
    func allocateForXLVehicle() {
        if isSlotAvailableForXLVehicle {
            let slots = getAvailableSpaces(for: .extraLarge)
            if slots.count > 0 {
                LocalStorage.shared.updateStorage(for: slots[0].bayId, isAvailable: false)
            } else {
                LocalStorage.shared.floorId = 0
                LocalStorage.shared.bayId = 0
            }
        } else {
            LocalStorage.shared.floorId = 0
            LocalStorage.shared.bayId = 0
            print("No Space Available")
        }
    }
}
