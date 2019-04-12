//
//  Service.swift
//  LocalSettings
//
//  Created by Luis Ezcurdia on 4/12/18.
//  Copyright © 2018 Luis Ezcurdia. All rights reserved.
//
import Foundation

class Service<T> where T: Codable {
    let session: URLSession
    let path: String
    private let authtoken: String?
    private let requestBuilder: RequestBuilder

    public init(session: URLSession, path: String, token: String?) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "ioslab-sample.herokuapp.com"
        self.path = path
        self.authtoken = token
        self.session = session
        self.requestBuilder = RequestBuilder(components: components)
    }

    // GET Index
    func index(completion: @escaping (ResponseResult<[T]>?) -> Void) {
        let request = requestBuilder.get(path: self.path, authtoken: self.authtoken, params: nil)
        let task = session.dataTask(with: request) { (data, response, error) in
            let handler = ResponseHandler<[T]>()
            handler.process(data: data, response: response, error: error, completion: completion)
        }
        task.resume()
    }

    // GET Show
    func show(_ remoteId: Int, completion: @escaping (ResponseResult<T>?) -> Void) {
        show(slug: String(remoteId), completion: completion)
    }

    func show(slug: String, completion: @escaping (ResponseResult<T>?) -> Void) {
        let request = requestBuilder.get(path: "\(self.path)/\(slug)", authtoken: self.authtoken, params: nil)
        let task = session.dataTask(with: request) { (data, response, error) in
            let handler = ResponseHandler<T>()
            handler.process(data: data, response: response, error: error, completion: completion)
        }
        task.resume()
    }

    // POST Create
    func create(resource: T, completion: @escaping (ResponseResult<T>?) -> Void) {
        var request = requestBuilder.post(path: self.path, authtoken: self.authtoken, params: nil)
        request.httpBody = try? JSONEncoder().encode(resource)
        let task = session.dataTask(with: request) { (data, response, error) in
            let handler = ResponseHandler<T>()
            handler.process(data: data, response: response, error: error, completion: completion)
        }
        task.resume()
    }

    // PUT Update
    func update(resource: T, completion: @escaping (ResponseResult<T>?) -> Void) {
        guard let remoteId = getId(resource: resource) else { return }
        var request = requestBuilder.put(path: "\(self.path)/\(remoteId)", authtoken: self.authtoken, params: nil)
        request.httpBody = try? JSONEncoder().encode(resource)
        let task = session.dataTask(with: request) { (data, response, error) in
            let handler = ResponseHandler<T>()
            handler.process(data: data, response: response, error: error, completion: completion)
        }
        task.resume()
    }

    // DELETE Destroy
    func destroy(resource: T, completion: @escaping (ResponseResult<T>?) -> Void) {
        guard let remoteId = getId(resource: resource) else { return }
        let request = requestBuilder.delete(path: "\(self.path)/\(remoteId)", authtoken: self.authtoken, params: nil)
        let task = session.dataTask(with: request) { (data, response, error) in
            let handler = ResponseHandler<T>()
            handler.process(data: data, response: response, error: error, completion: completion)
        }
        task.resume()
    }

    private func getId(resource: T) -> String? {
        if resource is Identifiable, let remoteId = (resource as? Identifiable)?.id {
            return String(remoteId)
        } else if resource is Slugable {
            return (resource as? Slugable)?.slug
        } else {
            return nil
        }
    }
}
