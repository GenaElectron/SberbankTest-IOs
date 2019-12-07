//
//  NibLoadable.swift
//  Sberbank-test-app
//
//  Created by Геннадий Бочаров on 05/12/2019.
//  Copyright © 2019 Геннадий Бочаров. All rights reserved.
//

import UIKit

protocol NibLoadable: class {
    static var nib: UINib { get }
}

extension NibLoadable {
    static var nib: UINib {
        return UINib(nibName: name, bundle: Bundle.init(for: self))
    }
    static var name: String {
        return String(describing: self)
    }
}

extension NibLoadable where Self: UIView {
    static func loadFromNib() -> Self {
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? Self else {
            fatalError()
        }
        return view
    }
    static func loadFromNibWithOwner() -> Self {
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? Self else {
            fatalError()
        }
        return view
    }
}
