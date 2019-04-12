//
//  ImageStore.swift
//  LocalSettings
//
//  Created by Luis Ezcurdia on 4/17/18.
//  Copyright © 2018 Luis Ezcurdia. All rights reserved.
//

import UIKit

class ImageStore {
    static let shared = ImageStore()
    let cache = NSCache<NSString, UIImage>()
    let storage = StorageType.permanent

    lazy var folder: URL = {
        return storage.folder
    }()

    init() {
        storage.ensureExists()
    }

    func imageURL(forKey key: String) -> URL {
        return folder.appendingPathComponent(key)
    }

    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)

        // Create full URL for image
        let url = imageURL(forKey: key)

        // Turn image into JPEG data
        if let data = UIImageJPEGRepresentation(image, 0.5) {
            // Write it to full URL
            try? data.write(to: url, options: [.atomic])
        }
    }

    func image(forKey key: String) -> UIImage? {
        if let existingImage = cache.object(forKey: key as NSString) {
            return existingImage
        }

        let url = imageURL(forKey: key)
        guard let imageFromDisk = UIImage(contentsOfFile: url.path) else {
            return nil
        }

        cache.setObject(imageFromDisk, forKey: key as NSString)
        return imageFromDisk
    }

    func deleteImage(forKey key: String) {
        cache.removeObject(forKey: key as NSString)

        let url = imageURL(forKey: key)
        do {
            try FileManager.default.removeItem(at: url)
        } catch let deleteError {
            print("Error removing the image from disk: \(deleteError)")
        }
    }

}
