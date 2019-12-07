//
//  UIViewController+Extensions.swift
//  Sberbank-test-app
//
//  Created by Геннадий Бочаров on 05/12/2019.
//  Copyright © 2019 Геннадий Бочаров. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(with title: String, and message: String, buttonTitle: String ,actionHandler: VoidClosure? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle, style: .default, handler: {_ in
            alertController.dismiss(animated: true, completion: nil)
            actionHandler?()
        })
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    func showAlertWithCancel(with title: String, and message: String, buttonTitle: String, cancellButtonTitle: String? = nil, cancelHandler: VoidClosure? = nil, actionHandler: VoidClosure? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle, style: .default, handler: {_ in
            alertController.dismiss(animated: true, completion: nil)
            actionHandler?()
        })
        let cancelButtonText = cancellButtonTitle ?? NSLocalizedString("alert.button.cancel", comment: "")
        let cancelAction = UIAlertAction(title: cancelButtonText, style: .cancel, handler: {_ in
            alertController.dismiss(animated: true, completion: nil)
            cancelHandler?()
        })
        alertController.addAction(action)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func showAlertNoInternetConnection() {
        if !self.isViewLoaded { return }
        
        let title = NSLocalizedString("alert.titleText.info", comment: "")
        let text = NSLocalizedString("alert.message.noInternetConnection", comment: "")
        let buttonTitle = NSLocalizedString("alert.button.ok", comment: "")
        showAlert(with: title, and: text, buttonTitle: buttonTitle)
    }
}
