//
//  Identifiable.swift
//  LocalSettings
//
//  Created by Luis Ezcurdia on 4/12/18.
//  Copyright © 2018 Luis Ezcurdia. All rights reserved.
//

import Foundation

protocol Identifiable {
    var id: Int? { get }
}

protocol Slugable {
    var slug: String? { get }
}
