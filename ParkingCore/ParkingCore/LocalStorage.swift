//
//  LocalStorage.swift
//  ParkingCore
//
//  Created by Ronak Malick on 06/02/24.
//

import Foundation

class LocalStorage: Storable {
    static let shared = LocalStorage()
    var model: [ParkingLot] = []
    var floorId = 0
    var bayId = 0
    
    private init() {}
    
    func updateStorage(for bayId: Int, isAvailable: Bool) {
        if let index = model.firstIndex(where: { $0.bayId == bayId }) {
            self.floorId = model[index].floor.rawValue
            self.bayId = model[index].bayId
            model[index].isAvailable = isAvailable
        } else {
            print("Element with Bay ID \(bayId) not found.")
        }
    }
    
    func saveInStorage(slot: ParkingLot) {
        model.append(slot)
    }
    
    func clearAll() {
        model.removeAll()
        model = []
    }
}
