//
//  LanguageListWireframe.swift
//  Sberbank-test-app
//
//  Created by Геннадий Бочаров on 04/12/2019.
//  Copyright © 2019 Геннадий Бочаров. All rights reserved.
//

import UIKit

final class LanguageListWireframe: BaseWireframe {

    // MARK: Module setup

    init(language: String, isOriginal: Bool) {
        let moduleViewController = LanguageListViewController.instantiate(fromStoryboardNamed: "MainStoryboard")
        super.init(viewController: moduleViewController)
        
        let interactor = LanguageListInteractor()
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
