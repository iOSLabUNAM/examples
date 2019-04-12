//
//  ImageManager.swift
//  LocalSettings
//
//  Created by Luis Ezcurdia on 4/13/18.
//  Copyright © 2018 Luis Ezcurdia. All rights reserved.
//

import Foundation
import UIKit

class ImageManager {
    static let shared = ImageManager()

    func download(url: URL, completion: @escaping ((UIImage) -> Void)) {
        if let image = ImageStore.shared.image(forKey: "avatar.png") {
            print("Fetch cached image")
            completion(image)
            return
        }
        print("Downloaing image...")
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try Data(contentsOf: url)
                guard let image = UIImage(data: data) else { return }
                print("[Complete]")
                ImageStore.shared.setImage(image, forKey: url.absoluteString)
                DispatchQueue.main.async { completion(image) }
            } catch let err {
                print("ERROR while downloading image: \(err)")
                return
            }
        }
    }
}
