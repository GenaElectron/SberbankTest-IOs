//
//  SettingsPresenter.swift
//  Sberbank-test-app
//
//  Created by Геннадий Бочаров on 04/12/2019.
//  Copyright © 2019 Геннадий Бочаров. All rights reserved.
//

import UIKit

final class SettingsPresenter {

    // MARK: Private properties

    private unowned let view: SettingsViewInterface
    private let interactor: SettingsInteractorInterface
    private let wireframe: SettingsWireframeInterface

    // MARK: Lifecycle

    init(view: SettingsViewInterface, interactor: SettingsInteractorInterface, wireframe: SettingsWireframeInterface) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

// MARK: Extensions SettingsPresenterInterface

extension SettingsPresenter: SettingsPresenterInterface {
}
