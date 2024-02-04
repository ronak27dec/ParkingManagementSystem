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
    let allocate: AllocationProtocol
    var slotNumber: (Int, Int) = (0,0)
    
    init(allocate: AllocationProtocol) {
        self.allocate = allocate
        super.init(nibName: "BookingViewController", bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.title = "Welcome Ronak"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func allocateButtonClicked(_ sender: UIButton) {
        let slotNumber = allocate.allocate(size: .small)
        self.slotNumber = slotNumber
        
        let floorId = slotNumber.floorId
        let bayId = slotNumber.bayId
        let slotNo = "[" + String(floorId) + ":" + String(bayId) + "]"
        slotNoLabel.text = slotNo
    }
 
    @IBAction func deallocateSpace(_ sender: UIButton) {
        let bayId = Int(bayIdTextField.text ?? "")
        allocate.deallocateSpace(for: bayId!)
    }
    
}
