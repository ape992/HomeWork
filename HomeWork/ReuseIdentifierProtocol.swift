//
//  ReuseIdentifierProtocol.swift
//  HomeWork
//
//  Created by 근식 on 2021/02/06.
//

import Foundation

protocol Reusable: class {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)

    }
}
