//
//  BookingViewController.swift
//  ParkingLotApp
//
//  Created by Ronak Malick on 04/02/24.
//

import UIKit
import ParkingCore

class BookingViewController: UIViewController {
    @IBOutlet weak var slotNoLabel: UILabel!
    @IBOutlet weak var bayIdTextField: UITextField!
    
    private var selectedVehicleType = VehicleType.small
    private var allocationService: AllocationServiceProtocol
    private var deallocationService: FreeUpSlotServiceProtocol
    
    private lazy var vm: BookingViewModel = {
        BookingViewModel(allocationService: allocationService, deallocationService: deallocationService)
    }()
    
    init(allocationService: AllocationServiceProtocol,
         deallocationService: FreeUpSlotServiceProtocol) {
        self.allocationService = allocationService
        self.deallocationService = deallocationService
        super.init(nibName: "BookingViewController", bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.title = "Welcome Ronak"
    }
    
    @IBAction func allocateButtonClicked(_ sender: UIButton) {
        vm.getSlotsForVehicleType(selectedVehicleType) { ticket in
            slotNoLabel.text = ticket
        }
    }
    
    @IBAction func deallocateSpace(_ sender: UIButton) {
        guard let idText = bayIdTextField.text,
              let bayId = Int(idText) else {
            assertionFailure("Bay Id must be Integer and non empty")
            return
        }
        vm.freeSlotWithBayID(bayId) { val in
            print("Slots freed with bay id \(bayId)")
        }
    }
    
    @IBAction func smallButtonClicked(_ sender: UIButton) {
        selectedVehicleType = .small
    }
    
    @IBAction func mediumButtonClicked(_ sender: UIButton) {
        selectedVehicleType = .medium
    }
    
    @IBAction func largeButtonClicked(_ sender: UIButton) {
        selectedVehicleType = .large
    }
    
    @IBAction func xlButtonClicked(_ sender: UIButton) {
        selectedVehicleType = .extraLarge
    }
}
