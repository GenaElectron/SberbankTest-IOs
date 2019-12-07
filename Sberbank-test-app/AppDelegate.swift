//
//  AppDelegate.swift
//  Sberbank-test-app
//
//  Created by Геннадий Бочаров on 04/12/2019.
//  Copyright © 2019 Геннадий Бочаров. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let dependency = AppDependency(networkService: NetworkService.shared,
                                       userDefaultsStorage: UserDefaultsStorage.shared,
                                       coreDataStorage: CoreDataStorage.shared)
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = MainTabBarWireframe(dependency).viewController
        self.window?.makeKeyAndVisible()
        return true
    }
}
