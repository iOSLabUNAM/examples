//
//  ModelViewControllerTests.swift
//  ModelViewControllerTests
//
//  Created by Luis Ezcurdia on 3/16/18.
//  Copyright © 2018 Luis Ezcurdia. All rights reserved.
//

import XCTest
@testable import ModelViewController

class UserTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testFullname() {
        let user = User(firstName: "John", lastName: "Smith", email: "joe.doe@example.com", gender: .male)
        XCTAssertEqual("John Smith", user.fullName)
    }

    func testFullnameWithNameOptional() {
        let user = User(firstName: nil, lastName: "Anderson", email: "joe.doe@example.com", gender: .male)
        XCTAssertEqual("Mr. Anderson", user.fullName)
    }

    func testFullnameWithLastNameOptional() {
        let user = User(firstName: "Jane", lastName: nil, email: "joe.doe@example.com", gender: .female)
        XCTAssertEqual("Jane Doe", user.fullName)
    }

    func testFullnameWithFirtAndLastNameOptionals() {
        let user = User(firstName: nil, lastName: nil, email: "joe.doe@example.com", gender: .female)
        XCTAssertEqual("No Name", user.fullName)
    }

    func testParse() {
        let decoder = JSONDecoder()
        let data = try! decoder.decode([User].self, from: self.data())
        XCTAssertEqual(data.count, 100)
        let user = data.first!
        XCTAssertEqual(user.firstName!, "Wilfred")
        XCTAssertEqual(user.lastName!, "Shields")
        XCTAssertEqual(user.email, "melvin.zulauf@wuckert.io")
        XCTAssertEqual(user.gender, Gender.female)
    }

    private func data() -> Data {
        let url = Bundle.main.url(forResource: "contacts", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
}
