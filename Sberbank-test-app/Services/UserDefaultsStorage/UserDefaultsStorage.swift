//
//  UserDefaultsStorage.swift
//  Sberbank-test-app
//
//  Created by Геннадий Бочаров on 04/12/2019.
//  Copyright © 2019 Геннадий Бочаров. All rights reserved.
//

import Foundation

import Foundation

enum UserDefaultsKeys: String {
    case originalLanguage = "com.app.sberbank.sourceLanguage"
    case translateLanguage = "com.app.sberbank.translateLanguage"
    case firstLaunch = "com.app.sberbank.firstLaunch"
}

protocol UserDefaultsStorageInterface: class {
    func setOriginalLanguage(_ value: Language)
    func getOriginalLanguage() -> Language?
    func setTranslateLanguage(_ value: Language)
    func getTranslateLanguage() -> Language?
}

final class UserDefaultsStorage {
    
    // MARK: Static properties

    static var shared = UserDefaultsStorage()
    
    // MARK: Private properties

    private let preferences = UserDefaults.standard
    
    // MARK: Init
    
    private init() {
        if isFirstLaunch() {
            setOriginalLanguage(Language(name: "English", key: "en"))
            setTranslateLanguage(Language(name: "Russian", key: "ru"))
        }
    }
        
    // MARK: Private methods
    
    private func isFirstLaunch() -> Bool {
        let first = preferences.bool(forKey: UserDefaultsKeys.firstLaunch.rawValue)
        if first == false {
            preferences.set(true, forKey: UserDefaultsKeys.firstLaunch.rawValue)
            return true
        }
        return false
    }
}

// MARK: Extensions UserDefaultsStorageInterface

extension UserDefaultsStorage: UserDefaultsStorageInterface {
    func setOriginalLanguage(_ value: Language) {
        guard let key = value.key, let name = value.name else { return }
        let dictionary = [key : name]
        preferences.set(dictionary, forKey: UserDefaultsKeys.originalLanguage.rawValue)
    }
    
    func getOriginalLanguage() -> Language? {
        if let dictionary = preferences.dictionary(forKey: UserDefaultsKeys.originalLanguage.rawValue) as? [String: String] {
            return Language(dictionary)
        }
        return nil
    }
    
    func setTranslateLanguage(_ value: Language) {
        guard let key = value.key, let name = value.name else { return }
        let dictionary = [key : name]
        preferences.set(dictionary, forKey: UserDefaultsKeys.translateLanguage.rawValue)
    }
    
    func getTranslateLanguage() -> Language? {
        if let dictionary = preferences.dictionary(forKey: UserDefaultsKeys.translateLanguage.rawValue) as? [String: String] {
            return Language(dictionary)
        }
        return nil
    }
}


