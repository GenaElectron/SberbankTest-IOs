//
//  HistoryWireframe.swift
//  Sberbank-test-app
//
//  Created by Геннадий Бочаров on 04/12/2019.
//  Copyright © 2019 Геннадий Бочаров. All rights reserved.
//

import UIKit

final class HistoryWireframe: BaseWireframe {
    
    // MARK: Private properties
    
    private let dependency: AppDependency?

    // MARK: Module setup

    init(_ dependency: AppDependency? = nil, delegate: HistoryDelegate? = nil) {
        self.dependency = dependency
        let moduleViewController = HistoryViewController.instantiate(fromStoryboardNamed: "MainStoryboard")
        super.init(viewController: moduleViewController)
        
        let interactor = HistoryInteractor()
        interactor.storage = dependency?.coreDataStorage
        
        let presenter = HistoryPresenter(view: moduleViewController, interactor: interactor, wireframe: self)
        moduleViewController.presenter = presenter
        presenter.delegate = delegate
    }

}

// MARK: Extensions WordListWireframeInterface

extension HistoryWireframe: HistoryWireframeInterface {
    func navigate(to option: HistoryNavigationOption) {
        switch option {
        case .translate:
            viewController.tabBarController?.selectedIndex = MainTabBarModule.translate.selectedIndex
        }
    }
}
