//
//  UITextViewWithPlaceholder.swift
//  Sberbank-test-app
//
//  Created by Геннадий Бочаров on 06/12/2019.
//  Copyright © 2019 Геннадий Бочаров. All rights reserved.
//

import UIKit

class UITextViewWithHandler: UITextView {
    typealias handler = ItemClosure<String>
    private var placeholderLabel: UILabel?
    private var handlerTextDidChange: handler?
    public func addClosureTextDidChange (_ closure: @escaping handler) {
        self.handlerTextDidChange = closure
    }
}

extension UITextViewWithHandler: UITextViewDelegate {
    override open var bounds: CGRect {
        didSet {
            self.resizePlaceholder()
        }
    }
    
    public var placeholder: String? {
        get {
            return placeholderLabel?.text
        }
        set {
            if let placeholderLabel = placeholderLabel {
                placeholderLabel.text = newValue
                placeholderLabel.sizeToFit()
            } else {
                self.addPlaceholder(newValue!)
            }
        }
    }
    
    public func hidePlaceholder() {
        if let placeholderLabel = placeholderLabel {
            placeholderLabel.isHidden = true
        }
    }
            
    public func textViewDidChange(_ textView: UITextView) {
        if let placeholderLabel = placeholderLabel {
            placeholderLabel.isHidden = self.text.count > 0
        }
        handlerTextDidChange?(textView.text)
    }
    
    private func resizePlaceholder() {
        if let placeholderLabel = placeholderLabel {
            let labelX = self.textContainer.lineFragmentPadding
            let labelY = self.textContainerInset.top + 2
            let labelWidth = self.frame.width - (labelX * 2)
            let labelHeight = placeholderLabel.frame.height
            placeholderLabel.frame = CGRect(x: labelX, y: labelY, width: labelWidth, height: labelHeight)
        }
    }
    
    private func addPlaceholder(_ placeholderText: String) {
        let placeholderLabel = UILabel()
        placeholderLabel.text = placeholderText
        placeholderLabel.sizeToFit()
        placeholderLabel.font = self.font
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.isHidden = self.text.count > 0
        self.addSubview(placeholderLabel)
        self.resizePlaceholder()
        self.delegate = self
        self.placeholderLabel = placeholderLabel
    }
}
