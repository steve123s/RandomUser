//
//  RandomUserTests.swift
//  RandomUserTests
//
//  Created by Daniel Esteban Salinas on 27/03/21.
//

import XCTest
@testable import RandomUser

class RandomUserTests: XCTestCase {
    
    var randomUser: RandomUser!

    override func setUpWithError() throws {
        super.setUp()
        let data =
            try Data.fromJSON(fileName: "GetRandomUserResponse")
        let decoder = JSONDecoder()
        randomUser = try decoder.decode(RandomUsersAPI.self, from: data).results.first
    }

    override func tearDownWithError() throws {
        randomUser = nil
        super.tearDown()
    }
    
    func testDecodeRandomUser_givenValidJSON_createsRandomUser() {
        XCTAssertNotNil(randomUser)
    }
    
    func testRandomUserCoordinates_coordinatesExist() {
        XCTAssertNotNil(randomUser?.location.coordinates)
    }
    
    func testRandomUserTimeZone_timeZoneExist() {
        XCTAssertNotNil(randomUser?.location.timeZone)
    }

}
