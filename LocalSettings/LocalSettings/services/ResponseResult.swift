//
//  ResponseResult.swift
//  LocalSettings
//
//  Created by Luis Ezcurdia on 4/12/18.
//  Copyright © 2018 Luis Ezcurdia. All rights reserved.
//

import Foundation

enum RespnseStatus {
    case success
    case notContent
    case notModified
    case badRequest
    case unauthorized
    case forbiden
    case notFound

    case invalid
    case error
    case parsingError

    init(rawValue: Int) {
        switch rawValue {
        case 200, 201:
            self = .success
        case 204:
            self = .notContent
        case 304:
            self = .notModified
        case 400:
            self = .badRequest
        case 401:
            self = .unauthorized
        case 403:
            self = .forbiden
        case 404:
            self = .notFound
        default:
            self = .error
        }
    }
}

class ResponseResult<T> where T: Codable {
    var status: RespnseStatus
    var object: T?
    var response: HTTPURLResponse?
    var error: Error?

    init(data: Data?, response: URLResponse?, error: Error?) {
        if let error = error {
            self.status = .error
            self.error = error
        }
        guard let response = response else {
            self.status = .invalid
            return
        }
        self.response = response as? HTTPURLResponse

        if data == nil {
            self.status = .notContent
        } else {
            self.status = RespnseStatus(rawValue: self.response?.statusCode ?? 500)
        }

    }
}
