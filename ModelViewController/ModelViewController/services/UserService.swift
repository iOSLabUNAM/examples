//
//  UserService.swift
//  ModelViewController
//
//  Created by Luis Ezcurdia on 3/16/18.
//  Copyright © 2018 Luis Ezcurdia. All rights reserved.
//

import Foundation

typealias UsersResponse = ([User]) -> Void
typealias UserResponse = (User) -> Void

class UserService {
    static let shared = UserService()

    private lazy var rawData: Data = {
        let url = Bundle.main.url(forResource: "contacts", withExtension: "json")!
        return try! Data(contentsOf: url)
    }()

    private lazy var data: [User] = {
        let decoder = JSONDecoder()
        return try! decoder.decode([User].self, from: self.rawData)
    }()

    // In an ideal world you get everything immediately
    func getUsers() -> [User] {
        return self.data
    }

    // In the real world there is some network async calls
    func getUsers(completion: @escaping UsersResponse) {
        print("[MAIN]: Start fetch")
        DispatchQueue.global(qos: .background).async {
            print("[BACKGROUND]: Start fetch")
            sleep(3)
            print("[BACKGROUND]: End fetch")
            DispatchQueue.main.async {
                print("[MAIN]: Clojure call start")
                completion(self.data)
                print("[MAIN]: Clojure call ended")
            }
            print("[BACKGROUND]: Close connection")
        }
        print("[MAIN]: End fetch")
    }
}
