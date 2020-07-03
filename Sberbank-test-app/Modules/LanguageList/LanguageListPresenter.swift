//
//  LanguageListPresenter.swift
//  Sberbank-test-app
//
//  Created by Геннадий Бочаров on 04/12/2019.
//  Copyright © 2019 Геннадий Бочаров. All rights reserved.
//

import UIKit

final class LanguageListPresenter {

    // MARK: Private properties
    
    private unowned let view: LanguageListViewInterface
    private let interactor: LanguageListInteractorInterface
    private let wireframe: LanguageListWireframeInterface
    private var languageName: String
    private var isOriginal: Bool
    
    // MARK: Lifecycle

    init(view: LanguageListViewInterface, interactor: LanguageListInteractorInterface, wireframe: LanguageListWireframeInterface, language: String, isOriginal: Bool) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
        self.languageName = language
        self.isOriginal = isOriginal
    }
    
    func viewDidLoad() {
        view.setupView()
        view.setTitle()
        loadLanguage()
    }
}

// MARK: Extensions LanguageListPresenterInterface

extension LanguageListPresenter: LanguageListPresenterInterface {
    func isOriginalLanguage() -> Bool {
        return isOriginal
    }
    
    func numberOrItems() -> Int {
        return interactor.getLanguageList().count
    }
    
    func item(at indexPath: IndexPath) -> LanguageItem {
        let lang = interactor.getLanguageList()[indexPath.row]
        return lang
    }
    
    func getCurrentLanguage() -> String {
        return self.languageName
    }
    
    func setSelectedLanguage(at indexPath: IndexPath) {
        let language = interactor.getLanguageList()[indexPath.row]
        self.languageName = language.name ?? ""
        if isOriginal {
            interactor.setOriginalLanguage(language)
        } else {
            interactor.setTranslateLanguage(language)
        }
        view.reloadTable()
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(150)) { [weak self] in
            guard let self = self else { return }
            self.wireframe.navigate(to: .close)
        }
    }
    
    func loadLanguage() {
        self.view.reloadTable()
    }
}
