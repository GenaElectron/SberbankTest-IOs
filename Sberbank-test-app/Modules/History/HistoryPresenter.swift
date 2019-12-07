//
//  HistoryPresenter.swift
//  Sberbank-test-app
//
//  Created by Геннадий Бочаров on 04/12/2019.
//  Copyright © 2019 Геннадий Бочаров. All rights reserved.
//

import UIKit

final class HistoryPresenter {
    
    // MARK: Public properties
    
    weak var delegate: HistoryDelegate?

    // MARK: Private properties

    private unowned let view: HistoryViewInterface
    private let interactor: HistotyInteractorInterface
    private let wireframe: HistoryWireframeInterface
    
    // MARK: Lifecycle

    init(view: HistoryViewInterface, interactor: HistotyInteractorInterface, wireframe: HistoryWireframeInterface) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
    
    func viewDidLoad() {
        view.setupView()
    }
    
    func viewWillAppear(animated: Bool) {
        interactor.fetchAllHistory {[weak self] in
            self?.view.reloadTableView()
        }
    }
    
    func viewWillDisappear(animated: Bool) {
        
    }
}

// MARK: Extensions WordListPresenterInterface

extension HistoryPresenter: HistoryPresenterInterface {
       
    func removeAllHistoryButtonTaped() {
        view.showAlertDeleteAction()
    }
    
    func removeAll() {
        interactor.removeAll()
        view.reloadTableView()
    }
    
    func numberOrItems() -> Int {
        if view.isFiltering() {
            return interactor.getAllSearchHistory().count
        }
        return interactor.getAllHistory().count
    }
    
    func item(at indexPath: IndexPath) -> HistoryItem {
        return interactor.getAllHistory()[indexPath.row]
    }
    
    func itemFilter(at indexPath: IndexPath) -> HistoryItem {
        return interactor.getAllSearchHistory()[indexPath.row]
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        var item: HistoryItem
        if view.isFiltering() {
            item = interactor.getAllSearchHistory()[indexPath.row]
        } else {
            item = interactor.getAllHistory()[indexPath.row]
        }
        delegate?.didSelect(item: item)
        wireframe.navigate(to: .translate)
    }
    
    func setFilter(text: String) {
        interactor.getFilterHistory(searchText: text) {
            self.view.reloadTableView()
        }
    }
    
}
