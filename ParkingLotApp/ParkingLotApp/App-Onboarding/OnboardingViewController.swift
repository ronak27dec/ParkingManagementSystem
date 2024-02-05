//
//  OnboardingViewController.swift
//  ParkingLotApp
//
//  Created by Ronak Malick on 04/02/24.
//

import UIKit
import ParkingCore

class OnboardingViewController: UIViewController {
    let service: ParkingLotServiceProtocol
    
    private lazy var vm: OnboardingViewModel = {
        return OnboardingViewModel(service: service)
    }()
    
    @IBOutlet weak var floorCountLabel: UITextField!
    @IBOutlet weak var smallCountLabel: UITextField!
    @IBOutlet weak var mediumCountLabel: UITextField!
    @IBOutlet weak var largeCountLabel: UITextField!
    @IBOutlet weak var xlCountLabel: UITextField!
    
    init(service: ParkingLotServiceProtocol) {
        self.service = service
        super.init(nibName: "OnboardingViewController", bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "SignUp"
        self.navigationController?.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    @IBAction func signupButtonClicked(_ sender: UIButton) {
        let floor = Int(floorCountLabel.text ?? "")
        let small = Int(smallCountLabel.text ?? "")
        let med = Int(mediumCountLabel.text ?? "")
        let large = Int(largeCountLabel.text ?? "")
        let xl = Int(xlCountLabel.text ?? "")
        
        vm.setupParkingLot(floors: floor ?? 3,
                           small: small ?? 100,
                           medium: med ?? 100,
                           large: large ?? 100,
                           xL: xl ?? 100) { val in
            let vc = BookingViewController(service: service)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
