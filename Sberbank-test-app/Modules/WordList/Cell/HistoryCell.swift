//
//  HistoryCell.swift
//  Sberbank-test-app
//
//  Created by Геннадий Бочаров on 04/12/2019.
//  Copyright © 2019 Геннадий Бочаров. All rights reserved.
//

import UIKit

class HistoryCell: UITableViewCell, NibLoadable {
    
    @IBOutlet weak var originalText: UILabel!
    @IBOutlet weak var translateText: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    public func configure(item lang: HistoryItem) {
        originalText.text = lang.originalText
        translateText.text = lang.translateText
    }
    
    override func prepareForReuse() {
        originalText.text = nil
        translateText.text = nil
    }

}
