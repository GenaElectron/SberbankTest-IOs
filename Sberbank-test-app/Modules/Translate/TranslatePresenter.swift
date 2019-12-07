//
//  TranslatePresenter.swift
//  Sberbank-test-app
//
//  Created by Геннадий Бочаров on 04/12/2019.
//  Copyright © 2019 Геннадий Бочаров. All rights reserved.
//

import UIKit

final class TranslatePresenter {
    
    // MARK: Private properties

    private unowned let view: TranslateViewInterface
    private let interactor: TranslateInteractorInterface
    private let wireframe: TranslateWireframeInterface
    
    private var translate: Bool = true

    // MARK: Lifecycle

    init(view: TranslateViewInterface, interactor: TranslateInteractorInterface, wireframe: TranslateWireframeInterface) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
    
    func viewDidLoad() {
        view.setupTarget()
    }
    
    func viewWillAppear(animated: Bool) {
        view.setTitleLanguageForButton(source: interactor.getOriginalLanguage(), translate: interactor.getTranslateLanguage())
        guard let text = view.getInputOriginalText(),
            text.isEmpty == false,
            self.translate else {
            translate = true
            return
        }
        translateText(text: text)
    }
    
    func viewWillDisappear(animated: Bool) {
        
    }
}

// MARK: Extensions TranslatePresenterInterface

extension TranslatePresenter: TranslatePresenterInterface {
    func turnOverLanguage() {
        interactor.turnOverLanguage()
        view.setTitleLanguageForButton(source: interactor.getOriginalLanguage(), translate: interactor.getTranslateLanguage())
    }
    
    func openLanguageList(lang: String, isOriginal: Bool) {
        wireframe.navigate(to: .openLanguageList(lang, isOriginal))
    }
        
    func translateText(text: String) {
        guard text.isEmpty == false else { return }
        interactor.translateText(text: text, completion: {[weak self] translateText in
            self?.view.setTextOutput(text: translateText)
        }, noIternetConnectionHandler: { [weak self] in
            self?.view.showAlertNoInternetConnection()
        })
    }
}

// MARK: Extensions HistoryDelegate

extension TranslatePresenter: HistoryDelegate {
    func didSelect(item history: HistoryItem) {
        translate = false
        let languages = interactor.getLanguageList()
        guard let originalLanguage = languages.first(where: {$0.key == history.originalLanguageID}) else { return }
        guard let translateLanguage = languages.first(where: {$0.key == history.translateLanguageID}) else { return }
        view.setTextFor(original: history.originalText, translate: history.translateText)
        interactor.setOriginalLanguage(originalLanguage)
        interactor.setTranslateLanguage(translateLanguage)
        view.setTitleLanguageForButton(source: originalLanguage.language, translate: translateLanguage.language)
    }
}
