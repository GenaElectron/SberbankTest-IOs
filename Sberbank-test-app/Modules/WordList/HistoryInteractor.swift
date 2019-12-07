//
//  HistoryInteractor.swift
//  Sberbank-test-app
//
//  Created by Геннадий Бочаров on 04/12/2019.
//  Copyright © 2019 Геннадий Бочаров. All rights reserved.
//

import Foundation

final class HistoryInteractor {
    private let storage = CoreDataStorage.shared
    
    private var historyData: [History] = []
    private var searchHistoryData: [History] = []
}

// MARK: Extensions WordListInteractorInterface

extension HistoryInteractor: HistotyInteractorInterface {
    func removeAll() {
        storage.deleteAll()
        historyData.removeAll()
    }
    
    func getAllHistory() -> [History] {
        return historyData
    }
    
    func fetchAllHistory(completion: @escaping VoidClosure) {
        storage.fetch(objectType: History.self, completion: {[weak self] data in
            guard let self = self else { return }
            self.historyData = data ?? []
            completion()
        })
    }
    
    func getAllSearchHistory() -> [History] {
        return searchHistoryData
    }

    func getFilterHistory(searchText: String, completion: @escaping VoidClosure) {
        storage.fetch(objectType: History.self, search: searchText, completion: {[weak self] data in
            guard let self = self else { return }
            self.searchHistoryData = data ?? []
            completion()
        })
    }
}
