//
//  LanguageListInterfaces.swift
//  Sberbank-test-app
//
//  Created by Геннадий Бочаров on 04/12/2019.
//  Copyright © 2019 Геннадий Бочаров. All rights reserved.
//

import UIKit

enum LanguageListNavigationOption {
    case close
}

protocol LanguageListWireframeInterface: WireframeInterface {
    func navigate(to option: LanguageListNavigationOption)
}

protocol LanguageListViewInterface: ViewInterface {
    func setupView()
    func reloadTable()
    func closeController()
    func setTitle()
}

protocol LanguageListPresenterInterface: PresenterInterface {
    func numberOrItems() -> Int
    func item(at indexPath: IndexPath) -> LanguageItem
    func getCurrentLanguage() -> String
    func setSelectedLanguage(at indexPath: IndexPath)
    func isOriginalLanguage() -> Bool
}

protocol LanguageListInteractorInterface: InteractorInterface {
    func getLanguageList() -> [Language]
}
