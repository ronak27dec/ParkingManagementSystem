//
//  AppMainRouter.swift
//  ParkingLotApp
//
//  Created by Ronak Malick on 04/02/24.
//

import Foundation
import UIKit

struct AppMainRouter: AppRoutable {
    var window: UIWindow
    var navigationController: UINavigationController

    init(window: UIWindow,
         navigationController: UINavigationController = UINavigationController()) {
        self.window = window
        self.navigationController = navigationController
        UINavigationBar.appearance().backIndicatorImage = UIImage(systemName: "arrowshape.backward")
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(systemName: "arrowshape.backward")
    }

    func launch() {
        let auth = AuthenticationViewController()
        navigationController.viewControllers = [auth]
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
