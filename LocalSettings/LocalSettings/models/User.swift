//
//  User.swift
//  LocalSettings
//
//  Created by Luis Ezcurdia on 4/12/18.
//  Copyright © 2018 Luis Ezcurdia. All rights reserved.
//

import Foundation

enum UserRole: String, Codable {
    case admin
    case moderator
    case user
}

struct User: Codable, Identifiable {
    let id: Int?
    let name: String
    let email: String
    let role: UserRole
    let token: String?
    let avatarAsset: ImageAsset?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case email
        case role
        case token
        case avatarAsset = "avatar_urls"
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(email, forKey: .email)
        try container.encode(role, forKey: .role)
        try container.encode(avatarAsset, forKey: .avatarAsset)
    }
}
