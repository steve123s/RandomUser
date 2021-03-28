//
//  APIManager+RandomUser.swift
//  RandomUser
//
//  Created by Daniel Esteban Salinas on 27/03/21.
//

import Foundation

extension APIManager {
    
    func getOneRandomUser(completion: @escaping (RandomUser) -> Void, onError: ((Error) -> Void)?) {
        let endpoint = API.RandomUser.getRandomUser.build()
        let request = API.Request(builder: endpoint, params: nil, headers: nil)
        request.run(type: RandomUsersAPI.self, completion: { response in
            guard let randomUser = response.results.first else {
                onError?(APIError.noDataError)
                return
            }
            completion(randomUser)
        }, onError: onError)
    }
    
}
