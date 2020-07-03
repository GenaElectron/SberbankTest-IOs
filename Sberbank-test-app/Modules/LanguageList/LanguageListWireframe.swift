//
//  LanguageListWireframe.swift
//  Sberbank-test-app
//
//  Created by Геннадий Бочаров on 04/12/2019.
//  Copyright © 2019 Геннадий Бочаров. All rights reserved.
//

import UIKit

final class LanguageListWireframe: BaseWireframe {
    
    // MARK: Private properties
    
    private let dependency: AppDependency?

    // MARK: Module setup

    init(_ dependency: AppDependency? = nil, language: String, isOriginal: Bool) {
        self.dependency = dependency
        let moduleViewController = LanguageListViewController.instantiate(fromStoryboardNamed: "MainStoryboard")
        super.init(viewController: moduleViewController)
        
        let interactor = LanguageListInteractor()
        interactor.networkService = dependency?.networkService
        interactor.userDefaults = dependency?.userDefaultsStorage
        
        let presenter = LanguageListPresenter(view: moduleViewController, interactor: interactor, wireframe: self, language: language, isOriginal: isOriginal)
        moduleViewController.presenter = presenter
    }

}

// MARK: Extensions LanguageListWireframeInterface

extension LanguageListWireframe: LanguageListWireframeInterface {
    func navigate(to option: LanguageListNavigationOption) {
        switch option {
        case .close:
            navigationController?.dismiss(animated: true, completion: nil)
        }
    }
    
}
