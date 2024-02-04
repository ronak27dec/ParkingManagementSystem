//
//  OnboardingViewController.swift
//  ParkingLotApp
//
//  Created by Ronak Malick on 04/02/24.
//

import UIKit
import ParkingCore

class OnboardingViewController: UIViewController {
    let allocation: AllocationProtocol = Allocate()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "SignUp"
        self.navigationController?.navigationItem.setHidesBackButton(true, animated: true)

    }
    
    @IBAction func signupButtonClicked(_ sender: UIButton) {
        allocation.setup(floors: 2, small: 3, medium: 3, large: 3, xL: 3)

        let vc = BookingViewController(allocate: allocation)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
