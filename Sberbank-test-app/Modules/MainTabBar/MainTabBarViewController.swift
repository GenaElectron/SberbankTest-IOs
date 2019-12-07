//
//  MainTabBarView.swift
//  Sberbank-test-app
//
//  Created by Геннадий Бочаров on 04/12/2019.
//  Copyright © 2019 Геннадий Бочаров. All rights reserved.
//

import UIKit

final class MainTabBarViewController: UITabBarController, StoryboardLoadable {

    // MARK: Public properties

    var presenter: MainTabBarPresenterInterface!
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        presenter.viewDidLoad()
    }
    
    private func configureView() {
        tabBar.tintColor = UIColor.black
        tabBar.isTranslucent = false
        tabBar.barTintColor = .tabBarBackColor
    }
}

// MARK: Extensions TabBarViewInterface

extension MainTabBarViewController: MainTabBarViewInterface {
    func display(_ viewControllers: [UIViewController]) {
        self.viewControllers = viewControllers
    }
}
