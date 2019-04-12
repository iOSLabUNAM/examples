//
//  RequestBuilder.swift
//  LocalSettings
//
//  Created by Luis Ezcurdia on 4/12/18.
//  Copyright © 2018 Luis Ezcurdia. All rights reserved.
//

import Foundation

struct RequestBuilder {
    let components: URLComponents

    func get(path: String, authtoken: String?, params: [String: String]?) -> URLRequest {
        return self.build("GET", path: path, authtoken: authtoken, params: params)
    }

    func post(path: String, authtoken: String?, params: [String: String]?) -> URLRequest {
        return self.build("POST", path: path, authtoken: authtoken, params: params)
    }

    func put(path: String, authtoken: String?, params: [String: String]?) -> URLRequest {
        return self.build("PUT", path: path, authtoken: authtoken, params: params)
    }

    func patch(path: String, authtoken: String?, params: [String: String]?) -> URLRequest {
        return self.build("PATCH", path: path, authtoken: authtoken, params: params)
    }

    func delete(path: String, authtoken: String?, params: [String: String]?) -> URLRequest {
        return self.build("DELETE", path: path, authtoken: authtoken, params: params)
    }

    func build(_ action: String, path: String, authtoken: String?, params: [String: String]?) -> URLRequest {
        var request = URLRequest(url: self.urlFor(path: path, params: params))
        request.httpMethod = action
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let token = authtoken {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        return request
    }

    private func urlFor(path: String, params: [String: String]?) -> URL {
        var urlCmp = self.components
        urlCmp.path = path
        var queryItems = urlCmp.queryItems ?? [URLQueryItem]()
        if let rawQueries = params {
            for (key, value) in rawQueries {
                queryItems.append(URLQueryItem(name: key, value: value))
            }
        }
        if !queryItems.isEmpty {
            urlCmp.queryItems = queryItems
        }
        return urlCmp.url!
    }
}
