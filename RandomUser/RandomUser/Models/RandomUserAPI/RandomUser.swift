//
//  RandomUser.swift
//  RandomUser
//
//  Created by Daniel Esteban Salinas on 27/03/21.
//

import Foundation

struct RandomUser: Codable {
    
    enum Gender: String, Codable {
        case male, female, other
    }
    
    let uuid: String
    let name: FullName
    let location: Address
    let email: String
    let username: String
    let cellPhone: String
    let pictureURL: String
    let gender: Gender
    
    private enum CodingKeys: String, CodingKey {
        case uuid
        case name
        case location
        case email
        case username
        case cellPhone = "cell"
        case pictureURL = "large"
        case gender
    }
    
    private enum NestingCodingKeys: String, CodingKey {
        case login
        case picture
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let loginDataContainer = try decoder.container(keyedBy: NestingCodingKeys.self).nestedContainer(keyedBy: CodingKeys.self, forKey: .login)
        let pictureDataContainer = try decoder.container(keyedBy: NestingCodingKeys.self).nestedContainer(keyedBy: CodingKeys.self, forKey: .picture)
        
        name = try container.decode(FullName.self, forKey: .name)
        location = try container.decode(Address.self, forKey: .location)
        email = try container.decode(String.self, forKey: .email)
        cellPhone = try container.decode(String.self, forKey: .cellPhone)
        gender = try container.decode(Gender.self, forKey: .gender)
        
        uuid = try loginDataContainer.decode(String.self, forKey: .uuid)
        username = try loginDataContainer.decode(String.self, forKey: .username)
        
        pictureURL = try pictureDataContainer.decode(String.self, forKey: .pictureURL)
    }
    
}
