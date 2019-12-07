//
//  AppDependency.swift
//  Sberbank-test-app
//
//  Created by Геннадий Бочаров on 07/12/2019.
//  Copyright © 2019 Геннадий Бочаров. All rights reserved.
//

import Foundation

struct AppDependency {
    let networkService: NetworkServiceInterface?
    let userDefaultsStorage: UserDefaultsStorageInterface?
    let coreDataStorage: CoreDataStorageInterface?

    init(networkService: NetworkServiceInterface? = nil,
         userDefaultsStorage: UserDefaultsStorageInterface? = nil,
         coreDataStorage: CoreDataStorageInterface? = nil
    )

    {
        self.networkService = networkService
        self.userDefaultsStorage = userDefaultsStorage
        self.coreDataStorage = coreDataStorage
    }
}
