//
//  Cell.swift
//  MinhaCorrida
//
//  Created by Jon DeMaagd on 9/13/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

protocol Cell: class {
    static var defaultReuseIdentifier: String { get }
}

extension Cell {
    static var defaultReuseIdentifier: String {
        return "\(self)"
    }
}
