//
//  OnboardingViewModel.swift
//  ParkingLotApp
//
//  Created by Ronak Malick on 05/02/24.
//

import Foundation
import ParkingCore

class OnboardingViewModel {
    private let service: ParkingLotService
    
    init(service: ParkingLotService) {
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
