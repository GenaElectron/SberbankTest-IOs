//
//  TranslateInteractor.swift
//  Sberbank-test-app
//
//  Created by Геннадий Бочаров on 04/12/2019.
//  Copyright © 2019 Геннадий Бочаров. All rights reserved.
//

import Foundation

final class TranslateInteractor {
    
    // MARK: Public properties

    var userDefaults: UserDefaultsStorageInterface?
    var networkService:  NetworkServiceInterface?
    var storage: CoreDataStorageInterface?
}

// MARK: Extensions TranslateInteractorInterface

extension TranslateInteractor: TranslateInteractorInterface {    
    func getOriginalLanguage() -> String {
        let text = NSLocalizedString("translate.selectLanguageButton.choose", comment: "")
        return userDefaults?.getOriginalLanguage()?.name ?? text
    }
    
    func setOriginalLanguage(_ language: Language) {
        userDefaults?.setOriginalLanguage(language)
    }
    
    func getTranslateLanguage() -> String {
        let text = NSLocalizedString("translate.selectLanguageButton.choose", comment: "")
        return userDefaults?.getTranslateLanguage()?.name ?? text
    }
    
    func setTranslateLanguage(_ language: Language) {
        userDefaults?.setTranslateLanguage(language)
    }
        
    func turnOverLanguage() {
        guard let originalLanguage = userDefaults?.getOriginalLanguage(),
            let translateLanguage = userDefaults?.getTranslateLanguage() else { return }
        userDefaults?.setOriginalLanguage(translateLanguage)
        userDefaults?.setTranslateLanguage(originalLanguage)
    }
    
    func getLanguageList() -> [Language] {
        return networkService?.supportedLanguages ?? []
    }
    
    func translateText(text: String, completion: @escaping ItemClosure<String>, noIternetConnectionHandler: @escaping VoidClosure) {
        guard let originalLanguageKey = userDefaults?.getOriginalLanguage()?.key,
            let translateLanguageKey = userDefaults?.getTranslateLanguage()?.key else { return }
        let direction = originalLanguageKey + "-" + translateLanguageKey
        networkService?.translate(text: text, lang: direction) {[weak self] translateText, error in
            guard let self = self else { return }
            if let translateText = translateText {
                self.storage?.insert(original: text, translate: translateText, direction: direction)
                DispatchQueue.main.async { completion(translateText) }
            }
            if let error = error {
                if (error as NSError).code == NSURLErrorNotConnectedToInternet {
                    print("--- NO INTERNET CONNECTION")
                    DispatchQueue.main.async { noIternetConnectionHandler() }
                }
            }

        }
    }
}
