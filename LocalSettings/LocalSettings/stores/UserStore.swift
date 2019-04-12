//
//  UserStore.swift
//  LocalSettings
//
//  Created by Luis Ezcurdia on 4/17/18.
//  Copyright © 2018 Luis Ezcurdia. All rights reserved.
//

import Foundation

class UserStore {
    static let shared = UserStore()
    let storage = StorageType.cache
    var user: User?

    lazy var folder: URL = {
        return storage.folder
    }()

    lazy var fileURL: URL = {
        folder.appendPathComponent("user.json")
        return folder
    }()

    init() {
        storage.ensureExists()
        self.user = fetch()
    }

    func fetch() -> User? {
        do {
            if let data = try? Data(contentsOf: self.fileURL) {
                return try JSONDecoder().decode(User.self, from: data)
            }
        } catch let err {
            print("Decoding Error: \(err)")
        }
        return nil
    }

    func save() -> Bool {
        guard let usr = self.user else { return false }
        do {
            let json = try JSONEncoder().encode(usr)
            try json.write(to: fileURL)
            return true
        } catch let err {
            print("Encoding Error: \(err)")
            return false
        }
    }

    func clear() -> Bool {
        do {
            try FileManager.default.removeItem(at: fileURL)
            return true
        } catch let err {
            print("Remove item error: \(err)")
            return false
        }
    }
}
