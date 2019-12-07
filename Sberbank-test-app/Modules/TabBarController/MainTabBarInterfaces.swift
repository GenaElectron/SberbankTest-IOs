//
//  MainTabBarInterfaces.swift
//  Sberbank-test-app
//
//  Created by Геннадий Бочаров on 04/12/2019.
//  Copyright © 2019 Геннадий Бочаров. All rights reserved.
//

import UIKit

enum MainTabBarModule: Int {
    case translate
    case history
    case settings
    var selectedIndex: Int {
        switch self {
        case .translate:
            return 0
        case .history:
            return 1
        case .settings:
            return 2
        }
    }
}

protocol MainTabBarWireframeInterface: WireframeInterface {
    func getViewControllers() -> [UIViewController]
}

protocol MainTabBarViewInterface: ViewInterface {
    func display(_ viewControllers: [UIViewController])
}

protocol MainTabBarPresenterInterface: PresenterInterface {
}

protocol MainTabBarInteractorInterface: InteractorInterface {
}
