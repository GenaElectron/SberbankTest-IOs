//
//  Language.swift
//  Sberbank-test-app
//
//  Created by Геннадий Бочаров on 04/12/2019.
//  Copyright © 2019 Геннадий Бочаров. All rights reserved.
//

import Foundation

protocol LanguageItem {
    var language: String? { get }
}

struct Language {
    var name: String? = nil
    var key: String? = nil
    
    init(_ dictionary: [String: Any]) {
        self.key = dictionary.keys.first
        self.name = dictionary.values.first as? String
    }
    
    init(name: String, key: String) {
        self.key = key
        self.name = name
    }
}

extension Language: LanguageItem {
    var language: String? {
        return name
    }
}
