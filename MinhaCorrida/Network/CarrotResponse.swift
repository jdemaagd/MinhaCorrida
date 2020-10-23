//
//  CarrotResponse.swift
//  MinhaCorrida
//
//  Created by Jon DeMaagd on 9/20/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

import Foundation

struct CarrotResponse: Codable {
    let statusCode: Int
    let statusMessage: String
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case statusMessage = "status_message"
    }
}

extension CarrotResponse: LocalizedError {
    var errorDescription: String? {
        return statusMessage
    }
}
