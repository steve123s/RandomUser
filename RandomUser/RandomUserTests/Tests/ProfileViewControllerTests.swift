//
//  ProfileViewControllerTests.swift
//  RandomUserTests
//
//  Created by Daniel Esteban Salinas on 28/03/21.
//

import XCTest
@testable import RandomUser

class ProfileViewControllerTests: XCTestCase {
    
    var sut: ProfileViewController!
    var randomUser: RandomUser!

    override func setUpWithError() throws {
        super.setUp()
        sut = UIStoryboard.loadMainStoryboardController(named: .ProfileViewController) as? ProfileViewController
        sut.loadViewIfNeeded()
        let data =
            try Data.fromJSON(fileName: "GetRandomUserResponse")
        let decoder = JSONDecoder()
        randomUser = try decoder.decode(RandomUsersAPI.self, from: data).results.first
    }

    override func tearDownWithError() throws {
        sut = nil
        randomUser = nil
        super.tearDown()
    }
    
    func testProfileVC_render() {
        // When
        sut.updateUI(with: randomUser)
        
        // Then
        XCTAssertTrue(sut.firstNameLabel.text!.contains(randomUser.name.title))
        XCTAssertTrue(sut.firstNameLabel.text!.contains(randomUser.name.first))
        XCTAssertTrue(sut.lastNameLabel.text!.contains(randomUser.name.last))
        XCTAssertTrue(sut.emailLabel.text!.contains(randomUser.email))
        XCTAssertTrue(sut.cellPhoneLabel.text!.contains(randomUser.cellPhone))
        XCTAssertTrue(sut.usernameLabel.text!.contains(randomUser.username))
        XCTAssertTrue(sut.genderLabel.text!.contains(randomUser.gender.rawValue))
        XCTAssertTrue(sut.streetLabel.text!.contains(randomUser.location.street.name))
        XCTAssertTrue(sut.streetLabel.text!.contains("\(randomUser.location.street.number)"))
        XCTAssertTrue(sut.cityLabel.text!.contains(randomUser.location.city))
        XCTAssertTrue(sut.stateLabel.text!.contains(randomUser.location.state))
        XCTAssertTrue(sut.countryLabel.text!.contains(randomUser.location.country))
        XCTAssertTrue(sut.postcodeLabel.text!.contains(randomUser.location.postcode))
    }
    
}
