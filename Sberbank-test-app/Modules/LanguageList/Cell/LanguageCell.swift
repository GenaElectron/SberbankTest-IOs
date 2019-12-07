//
//  LanguageCell.swift
//  SBBOLtest
//
//  Created by Erik Vildanov on 30/05/2019.
//  Copyright © 2019 Erik Vildanov. All rights reserved.
//

import UIKit

class LanguageCell: UITableViewCell, NibLoadable {

    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    public func configure(item lang: LanguageItem) {
        self.label.text = lang.language
    }
    
    override func prepareForReuse() {
        self.label.text = nil
        backgroundColor = nil
    }

}
