//
//  CarrotAPI.swift
//  MinhaCorrida
//
//  Created by Jon DeMaagd on 9/19/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

import Foundation

class CarrotAPI {
    static let functionBaseUrl = SecretsManager.azureMinhaCorridaBaseUrl
    static let functionKey =  SecretsManager.azureMinhaCorridaFunctionKey
    
    enum Endpoint {

        static let baseUrl = functionBaseUrl
        static let functionKeyParam = "?code=\(CarrotAPI.functionKey ?? "no key")"
        
        case listAllCarrots

        var url: URL {
            return URL(string: self.urlString)!
        }
        
        var urlString: String {
            switch self {
            case .listAllCarrots:
                return CarrotAPI.functionBaseUrl! + Endpoint.functionKeyParam
            }
        }
    }
    
    // Note: class because do not need instance of CarrotAPI to use it
    // Note: @escaping as completion handler in closure can run after this function is finished
    class func requestCarrotsList(completion: @escaping ([Carrot], Error?) -> Void) -> URLSessionTask {
        let task = taskForGETRequest(url: Endpoint.listAllCarrots.url, response: [Carrot].self) { (response, error) in
                if let response = response {
                    completion(response, nil)
                } else {
                    completion([], error)
                }
            }
        
        return task
    }
    
    // Note: class because do not need instance of CarrotAPI to use it
    // Note: @escaping as completion handler in closure can run after this function is finished
    class func taskForGETRequest<ResponseType: Decodable>(url: URL, response: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionDataTask {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                do {
                    let errorResponse = try decoder.decode(CarrotResponse.self, from: data) as Error
                    DispatchQueue.main.async {
                        completion(nil, errorResponse)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
        }
        task.resume()
        
        return task
    }
}
