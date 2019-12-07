//
//  TranslateViewController.swift
//  Sberbank-test-app
//
//  Created by Геннадий Бочаров on 04/12/2019.
//  Copyright © 2019 Геннадий Бочаров. All rights reserved.
//

import UIKit

final class TranslateViewController: UIViewController, StoryboardLoadable {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var sourceLanguageButton: UIButton!
    @IBOutlet weak var translateLanguageButton: UIButton!
    @IBOutlet weak var turnOverLanguageButton: UIButton!

    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var inputContainerViewText: UIView!
    @IBOutlet weak var outputContainerViewText: UIView!

    let inputTextView = UITextViewWithHandler()
    let outputTextView = UITextView()


    // MARK: Public properties

    var presenter: TranslatePresenterInterface!
    
    // MARK: Private properties
    
    var searchTimer: Timer?
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        hideNavigationBar()
        presenter.viewDidLoad()
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear(animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.viewWillDisappear(animated: animated)
        closeKEyboard()
    }
    
    private func configureView() {        
        view.backgroundColor = .mainBackColor
        
        backView.layer.cornerRadius = 10
        backView.clipsToBounds = true
        backView.backgroundColor = .white
                
        sourceLanguageButton.setTitleColor(.black, for: .normal)
        translateLanguageButton.setTitleColor(.black, for: .normal)
        
        inputTextView.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        inputTextView.placeholder = NSLocalizedString("translate.inputText.placeholder", comment: "")
        outputTextView.font = UIFont.systemFont(ofSize: 20, weight: .regular)
                
        outputTextView.isEditable = false

        inputTextView.translatesAutoresizingMaskIntoConstraints = false
        outputTextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.addEqualConstraintsFromSubView(inputTextView, toSuperView: inputContainerViewText)
        NSLayoutConstraint.addEqualConstraintsFromSubView(outputTextView, toSuperView: outputContainerViewText)
    }
    
    private func hideNavigationBar() {
        navigationController?.isNavigationBarHidden = true
    }
    
    private func showNavigationBar() {
        navigationController?.isNavigationBarHidden = false
    }
    
    private func closeKEyboard() {
        self.view.endEditing(true)
    }
    
    private func inputTextChange(text: String) {
        searchTimer?.invalidate()
        searchTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { _ in
            if text.isEmpty { self.setTextOutput(text: "") }
            DispatchQueue.global(qos: .userInteractive).async {
                self.presenter.translateText(text: text)
            }
        })
    }
}

// MARK: Extensions TranslateViewInterface

extension TranslateViewController: TranslateViewInterface {
    func setTitleLanguageForButton(source: String?, translate: String?) {
        sourceLanguageButton.setTitle(source, for: .normal)
        translateLanguageButton.setTitle(translate, for: .normal)
    }
    
    func setTextFor(original: String?, translate: String?) {
        inputTextView.text = original
        outputTextView.text = translate
        inputTextView.hidePlaceholder()
    }
    
    func setupTarget() {
        inputTextView.addClosureTextDidChange {[weak self] text in
            self?.inputTextChange(text: text)
        }
        sourceLanguageButton.addTarget(self, action: #selector(openLanguageList(sender:)), for: .touchUpInside)
        translateLanguageButton.addTarget(self, action: #selector(openLanguageList(sender:)), for: .touchUpInside)
        turnOverLanguageButton.addTarget(self, action: #selector(turnOverLanguage), for: .touchUpInside)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        self.view.addGestureRecognizer(gesture)
    }
    
    @objc func openLanguageList(sender: UIButton) {
        presenter.openLanguageList(lang: sender.currentTitle!, isOriginal: sender == sourceLanguageButton)
    }
    
    @objc func turnOverLanguage() {
        presenter.turnOverLanguage()
        guard let text = outputTextView.text else { return }
        inputTextView.text = text
        presenter.translateText(text: text)
    }
    
    @objc func closeKeyboard() {
        self.view.endEditing(true)
    }
    
    func setTextOutput(text: String) {
        outputTextView.text = text
    }
    
    func cleanText() {
        inputTextView.text.removeAll()
        outputTextView.text.removeAll()
    }
    
    func getInputOriginalText() -> String? {
        return inputTextView.text
    }
}

