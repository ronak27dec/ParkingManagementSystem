//
//  AuthViewModel.swift
//  ParkingLotApp
//
//  Created by Ronak Malick on 06/02/24.
//

import Foundation
import ParkingCore

class AuthViewModel {
    private let service: ParkingLotServiceProtocol
    
    init(service: ParkingLotServiceProtocol) {
        self.service = service
    }
    
    func setupParkingLot(floors: Int,
                         small: Int,
                         medium: Int,
                         large: Int,
                         xL: Int,
                         onCompletion: (Bool) -> Void) {
        service.setupParkingLotSpace(floors: floors,
                                     small: small,
                                     medium: medium,
                                     large: large,
                                     xL: xL)
        onCompletion(true)
    }
}
