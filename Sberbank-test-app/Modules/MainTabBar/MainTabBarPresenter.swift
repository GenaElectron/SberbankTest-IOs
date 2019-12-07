//
//  MainTabBarPresenter.swift
//  Sberbank-test-app
//
//  Created by Геннадий Бочаров on 04/12/2019.
//  Copyright © 2019 Геннадий Бочаров. All rights reserved.
//

import UIKit

final class MainTabBarPresenter {

    // MARK: Private properties

    private unowned let view: MainTabBarViewInterface
    private let interactor: MainTabBarInteractorInterface
    private let wireframe: MainTabBarWireframeInterface

    // MARK: Lifecycle

    init(view: MainTabBarViewInterface, interactor: MainTabBarInteractorInterface, wireframe: MainTabBarWireframeInterface) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
    
    func viewDidLoad() {
        setupViewControllers()
    }
    
    // MARK: Private methods
    
    private func setupViewControllers() {
        let controllers = wireframe.getViewControllers()
        view.display(controllers)
    }
}

// MARK: Extensions MainTabBarPresenterInterface

extension MainTabBarPresenter: MainTabBarPresenterInterface {
}

