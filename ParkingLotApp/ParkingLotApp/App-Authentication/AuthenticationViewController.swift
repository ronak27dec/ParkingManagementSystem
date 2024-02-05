//
//  AuthenticationViewController.swift
//  ParkingLotApp
//
//  Created by Ronak Malick on 04/02/24.
//

import UIKit
import ParkingCore

class AuthenticationViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let service: ParkingLotServiceProtocol = ParkingLotService()
    
    private lazy var vm: AuthViewModel = {
        return AuthViewModel(service: service)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signinButtonClicked(_ sender: UIButton) {
        vm.setupParkingLot(floors: 3,
                           small: 100,
                           medium: 100,
                           large: 100,
                           xL: 100) { val in
            let vc = BookingViewController(service: service)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func signupButtonClicked(_ sender: UIButton) {
        let vc = OnboardingViewController(service: service)
        navigationController?.pushViewController(vc, animated: true)
    }
}
