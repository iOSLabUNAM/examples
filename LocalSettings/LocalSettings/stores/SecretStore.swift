//
//  KeyValueStore.swift
//  LocalSettings
//
//  Created by Luis Ezcurdia on 4/14/18.
//  Copyright © 2018 Luis Ezcurdia. All rights reserved.
//

import Foundation

class SecretStore {
    static let shared = SecretStore()
    let storage = StorageType.permanent

    lazy var folder: URL = {
        return storage.folder
    }()

    lazy var fileURL: URL = {
        folder.appendPathComponent("secrets.archive")
        return folder
    }()

    private var dict: [String: String] = [String: String]()

    init() {
        storage.ensureExists()
        if let data = NSKeyedUnarchiver.unarchiveObject(withFile: fileURL.path) as? [String: String] {
            dict = data
        }
    }

    func set(_ value: String, forKey key: String) -> String? {
        dict[key] = value
        return dict[key]
    }

    func get(forKey key: String) -> String? {
        return dict[key]
    }

    func save() -> Bool {
        return NSKeyedArchiver.archiveRootObject(self.dict, toFile: fileURL.path)
    }
}
