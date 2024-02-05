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
    private let service: ParkingLotService
    private var slotNumber: (Int, Int) = (0,0)
    
    init(service: ParkingLotService) {
        self.service = service
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
        let slotNumber = service.getSlots(size: selectedVehicleType)
        self.slotNumber = slotNumber
        let floorId = slotNumber.floorId
        let bayId = slotNumber.bayId
        
        if floorId == 0 && bayId == 0 {
            slotNoLabel.text = "NO SLOTS FOUND"
        } else {
            
            let slotNo = "[" + String(floorId) + ":" + String(bayId) + "]"
            slotNoLabel.text = slotNo
        }
   
    }
    
    @IBAction func deallocateSpace(_ sender: UIButton) {
        let bayId = Int(bayIdTextField.text ?? "")
        service.freeSlots(for: bayId!)
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
