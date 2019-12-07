//
//  TypeAliases.swift
//  Sberbank-test-app
//
//  Created by Геннадий Бочаров on 05/12/2019.
//  Copyright © 2019 Геннадий Бочаров. All rights reserved.
//

import Foundation

typealias VoidClosure = (() -> Void)
typealias ItemClosure<T> = ((T) -> Void)
typealias OptionalItemClosure<T> = ((T?) -> Void)
typealias OptionalItemClosureWithError<T> = ((T?, Error?) -> Void)
