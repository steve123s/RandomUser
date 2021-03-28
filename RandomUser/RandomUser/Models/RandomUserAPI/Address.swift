//
//  Address.swift
//  RandomUser
//
//  Created by Daniel Esteban Salinas on 27/03/21.
//

import Foundation
import CoreLocation

struct Address: Codable {
    let street: Street
    let city: String
    let state: String
    let country: String
    let postcode: String
    
    private let latitude: Double?
    private let longitude: Double?
    
    private let timeZoneOffset: Int?
    
    var coordinates: CLLocationCoordinate2D? {
        guard let latitude = latitude, let longitude = longitude else { return nil }
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var timeZone: TimeZone? {
        guard let timeZoneOffset = timeZoneOffset else { return nil }
        return TimeZone(secondsFromGMT: timeZoneOffset)
    }
    
    private enum CodingKeys: String, CodingKey {
        case street
        case city
        case state
        case country
        case postcode
        case latitude
        case longitude
        case timeZoneOffset = "offset"
    }
    
    private enum NestingCodingKeys: String, CodingKey {
        case coordinates
        case timezone
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let coordinatesDataContainer = try decoder.container(keyedBy: NestingCodingKeys.self).nestedContainer(keyedBy: CodingKeys.self, forKey: .coordinates)
        let timeZoneDataContainer = try decoder.container(keyedBy: NestingCodingKeys.self).nestedContainer(keyedBy: CodingKeys.self, forKey: .timezone)
        
        street = try container.decode(Street.self, forKey: .street)
        city = try container.decode(String.self, forKey: .city)
        state = try container.decode(String.self, forKey: .state)
        country = try container.decode(String.self, forKey: .country)
        
        // Sometimes postcode comes as Int and others as String
        if let postcode = try? container.decode(Int.self, forKey: .postcode) {
            self.postcode = String(postcode)
        } else {
            self.postcode = try container.decode(String.self, forKey: .postcode)
        }
        
        let latitudeStr = try coordinatesDataContainer.decode(String.self, forKey: .latitude)
        latitude = Double(latitudeStr)
        
        let longitudeStr = try coordinatesDataContainer.decode(String.self, forKey: .longitude)
        longitude = Double(longitudeStr)
        
        var timeZoneOffsetStr = try timeZoneDataContainer.decode(String.self, forKey: .timeZoneOffset)
        timeZoneOffsetStr = timeZoneOffsetStr.replacingOccurrences(of: "-", with: "")
        timeZoneOffsetStr = timeZoneOffsetStr.replacingOccurrences(of: "+", with: "")
        timeZoneOffset = timeZoneOffsetStr.secondsFromString()
        
    }
    
}
