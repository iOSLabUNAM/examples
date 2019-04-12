//
//  User.swift
//  ModelViewController
//
//  Created by Luis Ezcurdia on 3/16/18.
//  Copyright © 2018 Luis Ezcurdia. All rights reserved.
//

import Foundation
import UIKit

struct User: Codable {
    let firstName: String?
    let lastName: String?
    let email: String
    let gender: Gender

    var fullName: String {
        switch (firstName, lastName) {
        case (.none, .none):
            return "No Name"
        case (.none, .some):
            return "\(gender.title) \(lastName!)"
        case (.some, .none):
            return "\(firstName ?? "") Doe"
        default:
            return "\(firstName ?? "") \(lastName ?? "")"
        }
    }

    var image: UIImage? {
        return UIImage(named: gender.imageName)
    }

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case email
        case gender
    }
}
