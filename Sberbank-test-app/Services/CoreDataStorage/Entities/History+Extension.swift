//
//  History+CoreDataProperties.swift
//  Sberbank-test-app
//
//  Created by Геннадий Бочаров on 04/12/2019.
//  Copyright © 2019 Геннадий Бочаров. All rights reserved.
//

import Foundation
import CoreData

protocol HistoryItem {
    var originalText: String? { get }
    var translateText: String? { get }
    var originalLanguageID: String? { get }
    var translateLanguageID: String? { get }
}

extension History {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<History> {
        return NSFetchRequest<History>(entityName: "History")
    }

    @NSManaged public var original: String
    @NSManaged public var translate: String
    @NSManaged public var direction: String
}

extension History: HistoryItem {    
    var originalLanguageID: String? {
        let substrings = direction.components(separatedBy: "-")
        return substrings.first
    }
    
    var translateLanguageID: String? {
        let substrings = direction.components(separatedBy: "-")
        return substrings.last
    }
    
    var translateText: String? {
        return translate
    }
    
    var originalText: String? {
        return original
    }
}
