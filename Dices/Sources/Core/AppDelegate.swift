//
//  AppDelegate.swift
//  Dices
//
//  Created by Krygu on 27/02/2019.
//  Copyright © 2019 Krygu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        let navigationController = createNavigationVC()
        window?.rootViewController = navigationController
        let viewModel = DicesViewModelImpl(diceProvider: DiceProviderImpl(), dicesQuantity: 12)
        let dicesVC = DicesViewController(viewModel: viewModel)
        navigationController.pushViewController(dicesVC, animated: true)
        window?.makeKeyAndVisible()
        
        return true
    }
    
    private func createNavigationVC() -> UINavigationController {
        let navigationController = UINavigationController()
        navigationController.navigationBar.barStyle = .black
        navigationController.navigationBar.barTintColor = Theme.main.colors.primaryColor
        navigationController.navigationBar.prefersLargeTitles = true
        return navigationController
    }

}

