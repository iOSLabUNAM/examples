//
//  ResponseHandler.swift
//  LocalSettings
//
//  Created by Luis Ezcurdia on 4/12/18.
//  Copyright © 2018 Luis Ezcurdia. All rights reserved.
//

import Foundation

class ResponseHandler<T> where T: Codable {
    let decoder = JSONDecoder()

    func process(data: Data?,
                 response: URLResponse?,
                 error: Error?,
                 completion: @escaping (ResponseResult<T>?) -> Void) {
        let result = ResponseResult<T>(data: data, response: response, error: error)
        if result.status == RespnseStatus.success {
            do {
                result.object = try decoder.decode(T.self, from: data!)
                DispatchQueue.main.async { completion(result) }
            } catch let err {
                print("ERROR parsing \(String(describing: T.self)): \(err)")
                result.status = .parsingError
                DispatchQueue.main.async { completion(result) }
            }
        } else {
            DispatchQueue.main.async { completion(result) }
        }
    }
}
