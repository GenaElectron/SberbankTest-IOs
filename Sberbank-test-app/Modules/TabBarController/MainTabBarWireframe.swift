//
//  MainTabBarWireframe.swift
//  Sberbank-test-app
//
//  Created by Геннадий Бочаров on 04/12/2019.
//  Copyright © 2019 Геннадий Бочаров. All rights reserved.
//

import UIKit

final class MainTabBarWireframe: BaseWireframe {

    // MARK: Module setup

    init() {
        let moduleViewController = MainTabBarViewController.instantiate(fromStoryboardNamed: "MainStoryboard")
        super.init(viewController: moduleViewController)
        
        let interactor = MainTabBarInteractor()
        let presenter = MainTabBarPresenter(view: moduleViewController, interactor: interactor, wireframe: self)
        moduleViewController.presenter = presenter
    }

}

// MARK: Extensions MainTabBarWireframeInterface

extension MainTabBarWireframe: MainTabBarWireframeInterface {
    func getViewControllers() -> [UIViewController] {
        let translateTabBarItem = UITabBarItem()
        translateTabBarItem.image = UIImage(named: "transtate")
        
        let translateVC = TranslateWireframe().viewController
        translateVC.tabBarItem = translateTabBarItem
        let worldListDelegate = (translateVC as? TranslateViewController)?.presenter
        
        let wordListTabBarItem = UITabBarItem()
        wordListTabBarItem.image = UIImage(named: "list")
        
        let wordListVC = HistoryWireframe(delegate: worldListDelegate).viewController
        wordListVC.tabBarItem = wordListTabBarItem
        
        let settingsTabBarItem = UITabBarItem()
        settingsTabBarItem.image = UIImage(named: "settings")
        
        let settingsVC = SettingsWireframe().viewController
        settingsVC.tabBarItem = settingsTabBarItem
        
        return [
            translateVC,
            wordListVC,
            settingsVC,
            ].map { UINavigationController(rootViewController: $0) }
    }
}
