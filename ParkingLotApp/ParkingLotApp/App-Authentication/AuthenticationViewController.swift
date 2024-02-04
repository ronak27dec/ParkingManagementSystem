//
//  AuthenticationViewController.swift
//  ParkingLotApp
//
//  Created by Ronak Malick on 04/02/24.
//

import UIKit

class AuthenticationViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func signinButtonClicked(_ sender: UIButton) {
    }
    
    @IBAction func signupButtonClicked(_ sender: UIButton) {        
        let vc = OnboardingViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
