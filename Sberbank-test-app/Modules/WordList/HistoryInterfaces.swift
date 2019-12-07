//
//  HistoryInterfaces.swift
//  Sberbank-test-app
//
//  Created by Геннадий Бочаров on 04/12/2019.
//  Copyright © 2019 Геннадий Бочаров. All rights reserved.
//

import UIKit

enum HistoryNavigationOption {
    case translate
}

protocol HistoryWireframeInterface: WireframeInterface {
    func navigate(to option: HistoryNavigationOption)
}

protocol HistoryViewInterface: ViewInterface {
    func setupView()
    func reloadTableView()
    func isFiltering() -> Bool
    func showAlertDeleteAction()
}

protocol HistoryPresenterInterface: PresenterInterface {
    var delegate: HistoryDelegate? { get set }
    func numberOrItems() -> Int
    func item(at indexPath: IndexPath) -> HistoryItem
    func removeAll()
    func didSelectItem(at indexPath: IndexPath)
    func removeAllHistoryButtonTaped()
    func itemFilter(at indexPath: IndexPath) -> HistoryItem
    func setFilter(text: String)
}

protocol HistotyInteractorInterface: InteractorInterface {
    var storage: CoreDataStorageInterface? { get set }
    func fetchAllHistory(completion: @escaping VoidClosure)
    func getAllHistory() -> [History]
    func getAllSearchHistory() -> [History]
    func removeAll()
    func getFilterHistory(searchText: String, completion: @escaping VoidClosure)
}

protocol HistoryDelegate: class {
    func didSelect(item history: HistoryItem)
}
