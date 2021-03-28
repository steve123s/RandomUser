//
//  API+RandomUser.swift
//  RandomUser
//
//  Created by Daniel Esteban Salinas on 27/03/21.
//

import Foundation

extension API {

    enum RandomUser: APIProtocol {

        var base: String {
            #if PRODUCTION
            return "https://randomuser.me/"
            #else
            return "https://randomuser.me/"
            #endif
        }

        case getRandomUser

        func build() -> RequestBuilder {

            let url = base + "api/"

            switch self {
            case .getRandomUser: return (url, .get)
            }

        }

    }

}
