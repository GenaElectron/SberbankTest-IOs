//
//  TranslateInterfaces.swift
//  Sberbank-test-app
//
//  Created by Геннадий Бочаров on 04/12/2019.
//  Copyright © 2019 Геннадий Бочаров. All rights reserved.
//

import UIKit

enum TranslateNavigationOption {
    case openLanguageList(String, Bool)
}

protocol TranslateWireframeInterface: WireframeInterface {
    func navigate(to option: TranslateNavigationOption)
}

protocol TranslateViewInterface: ViewInterface {
    func openLanguageList(sender: UIButton)
    func setupTarget()
    func setTitleLanguageForButton(source: String?, translate: String?)
    func setTextFor(original: String?, translate: String?)
    func turnOverLanguage()
    func closeKeyboard()
    func setTextOutput(text: String)
    func cleanText()
    func getInputOriginalText() -> String?
    func showAlertNoInternetConnection()
}

protocol TranslatePresenterInterface: PresenterInterface, HistoryDelegate {
    func openLanguageList(lang: String, isOriginal: Bool)
    func turnOverLanguage()
    func translateText(text: String)
}

protocol TranslateInteractorInterface: InteractorInterface {
    var userDefaults: UserDefaultsStorageInterface? { get }
    var networkService:  NetworkServiceInterface? { get }
    var storage: CoreDataStorageInterface? { get }
    func getLanguageList() -> [Language]
    func getOriginalLanguage() -> String
    func setOriginalLanguage(_ language: Language)
    func getTranslateLanguage() -> String
    func setTranslateLanguage(_ language: Language)
    func turnOverLanguage()
    func translateText(text: String, completion: @escaping ItemClosure<String>, noIternetConnectionHandler: @escaping VoidClosure)
}
