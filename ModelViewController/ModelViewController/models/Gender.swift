//
//  Gender.swift
//  ModelViewController
//
//  Created by Luis Ezcurdia on 3/16/18.
//  Copyright © 2018 Luis Ezcurdia. All rights reserved.
//

import Foundation

enum Gender: String, Codable {
    case male
    case female

    var imageName: String {
        switch self {
        case .male:
            return "moon"
        case .female:
            return "sun"
        }
    }

    var title: String {
        switch self {
        case .male:
            return "Mr."
        case .female:
            return "Mrs."
        }
    }
}
