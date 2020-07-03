//
//  LanguageListViewController.swift
//  Sberbank-test-app
//
//  Created by Геннадий Бочаров on 04/12/2019.
//  Copyright © 2019 Геннадий Бочаров. All rights reserved.
//

import UIKit

final class LanguageListViewController: UIViewController, StoryboardLoadable {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var tableView: UITableView!

    // MARK: Public properties

    var presenter: LanguageListPresenterInterface!

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        presenter.viewDidLoad()
    }
    
    private func configureView() {
        navigationController?.navigationBar.barTintColor = .mainBackColor
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.isTranslucent = false
    }
	
}

// MARK: Extensions LanguageListViewInterface

extension LanguageListViewController: LanguageListViewInterface {
    func setTitle() {
        if presenter.isOriginalLanguage() {
            self.title = NSLocalizedString("languageList.originalLanguageTitle", comment: "")
        } else {
            self.title = NSLocalizedString("languageList.translateLanguageTitle", comment: "")
        }
    }
    
    @objc func closeController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func reloadTable() {
        tableView.reloadData()
    }
    
    func setupView() {
        tableView.register(LanguageCell.nib, forCellReuseIdentifier: LanguageCell.name)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "close"), style: .plain, target: self, action: #selector(closeController))
    }
}

// MARK: Extensions UITableViewDataSource

extension LanguageListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOrItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: LanguageCell.name, for: indexPath) as? LanguageCell {
            let item = presenter.item(at: indexPath)
            if item.language == presenter.getCurrentLanguage() {
                cell.label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
            } else {
                cell.label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            }
            cell.configure(item: item)
            return cell
        }
        return UITableViewCell()
    }
}

// MARK: Extensions LanguageListViewController

extension LanguageListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.setSelectedLanguage(at: indexPath)
    }
}
