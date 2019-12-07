//
//  TranslateWireframe.swift
//  Sberbank-test-app
//
//  Created by Геннадий Бочаров on 04/12/2019.
//  Copyright © 2019 Геннадий Бочаров. All rights reserved.
//

import UIKit

final class TranslateWireframe: BaseWireframe {

    // MARK: Module setup

    init() {
        let moduleViewController = TranslateViewController.instantiate(fromStoryboardNamed: "MainStoryboard")
        super.init(viewController: moduleViewController)
        
        let interactor = TranslateInteractor()
        let presenter = TranslatePresenter(view: moduleViewController, interactor: interactor, wireframe: self)
        moduleViewController.presenter = presenter
    }

}

// MARK: Extensions TranslateWireframeInterface

extension TranslateWireframe: TranslateWireframeInterface {
    
    func navigate(to option: TranslateNavigationOption) {
        switch option {
        case .openLanguageList(let lang, let isOriginal):
            let languageListWireframe = LanguageListWireframe(language: lang, isOriginal: isOriginal)
            let navigationController = UINavigationController(rootViewController: languageListWireframe.viewController)
            viewController.present(navigationController, animated: true)
        }
    }
}
