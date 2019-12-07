//
//  SettingsViewController.swift
//  Sberbank-test-app
//
//  Created by Геннадий Бочаров on 04/12/2019.
//  Copyright © 2019 Геннадий Бочаров. All rights reserved.
//

import UIKit

final class SettingsViewController: UIViewController, StoryboardLoadable {

    // MARK: Public properties

    var presenter: SettingsPresenterInterface!

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
        navigationItem.title = NSLocalizedString("settings.title", comment: "")
        navigationController?.navigationBar.barTintColor = .mainBackColor
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.layoutIfNeeded()
    }
	
}

// MARK: Extensions SettingsViewInterface

extension SettingsViewController: SettingsViewInterface {
}
