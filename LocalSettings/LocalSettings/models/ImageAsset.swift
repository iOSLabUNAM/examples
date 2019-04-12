//
//  ImageAsset.swift
//  LocalSettings
//
//  Created by Luis Ezcurdia on 4/12/18.
//  Copyright © 2018 Luis Ezcurdia. All rights reserved.
//

import Foundation
import UIKit

struct ImageAsset: Codable {
    let largeUrlString: String?
    let mediumUrlString: String?
    let smallUrlString: String?
    let thumbUrlString: String?

    enum CodingKeys: String, CodingKey {
        case largeUrlString  = "large"
        case mediumUrlString = "medium"
        case smallUrlString  = "small"
        case thumbUrlString  = "thumb"
    }

    var largeUrl: URL? {
        guard let urlString = largeUrlString else { return nil }
        return URL(string: urlString)
    }
    var mediumUrl: URL? {
        guard let urlString = mediumUrlString else { return nil }
        return URL(string: urlString)
    }
    var smallUrl: URL? {
        guard let urlString = smallUrlString else { return nil }
        return URL(string: urlString)
    }
    var thumbUrl: URL? {
        guard let urlString = thumbUrlString else { return nil }
        return URL(string: urlString)
    }

    func imageLarge(completion: @escaping ((UIImage) -> Void)) {
        guard let url = largeUrl else { return }
        ImageManager.shared.download(url: url, completion: completion)
    }

    func imageMedium(completion: @escaping ((UIImage) -> Void)) {
        guard let url = mediumUrl else { return }
        ImageManager.shared.download(url: url, completion: completion)
    }

    func imageSmall(completion: @escaping ((UIImage) -> Void)) {
        guard let url = smallUrl else { return }
        ImageManager.shared.download(url: url, completion: completion)
    }

    func imageThumb(completion: @escaping ((UIImage) -> Void)) {
        guard let url = thumbUrl else { return }
        ImageManager.shared.download(url: url, completion: completion)
    }
}
