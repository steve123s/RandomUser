//
//  API.swift
//  RandomUser
//
//  Created by Daniel Esteban Salinas on 27/03/21.
//

import Foundation

//------------------------------------
// MARK: - Protocol
//------------------------------------

protocol APIProtocol {
    var base: String { get }
    func build() -> API.RequestBuilder
}

enum APIError: Error {
    case noDataError
}

enum HTTPMethod: String {
    case get = "GET"
}

public typealias Parameters = [String: Any]
public typealias HTTPHeaders = [String: String]

//------------------------------------
// MARK: - API
//------------------------------------

struct API {

    //------------------------------------
    // MARK: - Typealiases
    //------------------------------------

    typealias RequestBuilder = (url: String, method: HTTPMethod)

    //------------------------------------
    // MARK: - Private Methods
    //------------------------------------

    private static func router(builder: RequestBuilder, params: Parameters?, headers: HTTPHeaders?) -> URLRequest? {

        guard let url = URL(string: builder.url) else { return nil }
        var request = URLRequest(url: url)
        
        // Add Headers
        if let headers = headers {
            for key in headers.keys {
                if let value = headers[key] {
                    request.addValue(value, forHTTPHeaderField: key)
                }
            }
        }
        
        // Add Method
        request.httpMethod = builder.method.rawValue
        
        return request

    }

    //------------------------------------
    // MARK: - Request with run methods
    //------------------------------------

    struct Request {

        let builder: RequestBuilder
        let parameters: Parameters?
        var headers: HTTPHeaders?

        init(builder: RequestBuilder, params: Parameters?, headers: HTTPHeaders?) {
            self.builder = builder
            self.parameters = params
            self.headers = headers
        }
        
        func run<T: Decodable>(type: T.Type,
                               completion: @escaping (T) -> Void,
                               onError: ((Error) -> Void)? = nil) {
            
            guard let request = API.router(builder: builder, params: parameters, headers: headers) else { return }
            
            let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in

                guard let data = data else {
                    onError?(APIError.noDataError)
                    return
                }
                
                let decoder = JSONDecoder()
                
                do {
                    let object = try decoder.decode(type, from: data)
                    completion(object)
                } catch {
                    onError?(error)
                }
                
            })

            task.resume()
        }

    }

}
