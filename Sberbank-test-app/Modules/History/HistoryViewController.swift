//
//  HistoryViewController.swift
//  Sberbank-test-app
//
//  Created by Геннадий Бочаров on 04/12/2019.
//  Copyright © 2019 Геннадий Бочаров. All rights reserved.
//

import UIKit

final class HistoryViewController: UIViewController, StoryboardLoadable {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var tableView: UITableView!

    // MARK: Public properties

    var presenter: HistoryPresenterInterface!
    
    // MARK: Private properties

    private let searchController = UISearchController(searchResultsController: nil)

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear(animated: animated)
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.viewWillDisappear(animated: animated)
        searchController.isActive = false
    }
    
    private func configureView() {
        navigationItem.title = NSLocalizedString("history.title", comment: "")
        navigationController?.navigationBar.barTintColor = .mainBackColor
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.layoutIfNeeded()

        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchBar.autocapitalizationType = .none
                
        searchController.searchBar.barTintColor = .white
        searchController.searchBar.tintColor = .black
        searchController.searchBar.searchBarStyle = .default
        
        tableView.register(HistoryCell.nib, forCellReuseIdentifier: HistoryCell.name)
        tableView.delegate = self
        tableView.dataSource = self
        navigationItem.searchController = searchController
        tableView.tableFooterView = UIView(frame: .zero)
        
        definesPresentationContext = true
    }
    
    @IBAction private func removeAll(_ sender: Any) {
        presenter.removeAllHistoryButtonTaped()
    }
    
    private func closeKEyboard() {
        self.view.endEditing(true)
    }
}

// MARK: Extensions WordListViewInterface

extension HistoryViewController: HistoryViewInterface {
    func setupView() {

    }
            
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && searchController.searchBar.text?.isEmpty == false
    }
    
    func showAlertDeleteAction() {
        let title = NSLocalizedString("alert.titleText.info", comment: "")
        let text = NSLocalizedString("Are you sure you want to delete the all history?", comment: "")
        let buttonTitle = NSLocalizedString("alert.button.yes", comment: "")
        showAlertWithCancel(with: title, and: text, buttonTitle: buttonTitle) {
            self.presenter.removeAll()
        }
    }
}

// MARK: Extensions UITableViewDataOriginal

extension HistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOrItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: HistoryCell.name, for: indexPath) as? HistoryCell {
            if isFiltering() {
                cell.configure(item: presenter.itemFilter(at: indexPath))
            } else {
                cell.configure(item: presenter.item(at: indexPath))
            }
            return cell
        }
        return UITableViewCell()
    }
}

// MARK: Extensions UITableViewDelegate

extension HistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectItem(at: indexPath)
    }
}

// MARK: Extensions UISearchResultsUpdating

extension HistoryViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        presenter.setFilter(text: searchController.searchBar.text!)
    }
}

// MARK: Extensions UISearchControllerDelegate

extension HistoryViewController: UISearchControllerDelegate {
    func didPresentSearchController(_ searchController: UISearchController) {
        DispatchQueue.main.async { [weak self] in
            self?.searchController.searchBar.becomeFirstResponder()
        }
    }
}
