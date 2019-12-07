//
//  LanguageListInteractor.swift
//  Sberbank-test-app
//
//  Created by Геннадий Бочаров on 04/12/2019.
//  Copyright © 2019 Геннадий Бочаров. All rights reserved.
//

import Foundation

final class LanguageListInteractor {
    
    // MARK: Public properties
    
    var networkService: NetworkServiceInterface?
}

// MARK: Extensions LanguageListInteractorInterface

extension LanguageListInteractor: LanguageListInteractorInterface {
    func getLanguageList() -> [Language] {
        return networkService?.supportedLanguages ?? []
    }
    
}

