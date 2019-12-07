//
//  SettingsWireframe.swift
//  Sberbank-test-app
//
//  Created by Геннадий Бочаров on 04/12/2019.
//  Copyright © 2019 Геннадий Бочаров. All rights reserved.
//

import UIKit

final class SettingsWireframe: BaseWireframe {

    // MARK: Module setup

    init() {
        let moduleViewController = SettingsViewController.instantiate(fromStoryboardNamed: "MainStoryboard")
        super.init(viewController: moduleViewController)
        
        let interactor = SettingsInteractor()
        let presenter = SettingsPresenter(view: moduleViewController, interactor: interactor, wireframe: self)
        moduleViewController.presenter = presenter
    }

}

// MARK: Extensions SettingsWireframeInterface

extension SettingsWireframe: SettingsWireframeInterface {
}
