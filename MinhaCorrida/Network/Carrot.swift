//
//  Carrot.swift
//  MinhaCorrida
//
//  Created by Jon DeMaagd on 9/19/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

import Foundation

struct Carrot: Codable {
    let id: String
    let carrotId: String
    let createdDate: String
    let distance: String
    let imageUrl: String       // TODO: move images to blob storage
    let information: String
    let name: String
    
    static var allCarrots: [Carrot] = []
    
    enum CodingKeys: String, CodingKey {
        case id, distance, information, name
        case carrotId = "carrot_id"
        case createdDate = "created_date"
        case imageUrl = "image_url"
    }
    
    
    // TODO: No Network!!
    static func best(for distance: Double) -> Carrot {
        return allCarrots.filter { Double($0.distance)! < distance }.last ?? allCarrots.first!
    }
    static func next(for distance: Double) -> Carrot {
        return allCarrots.filter { distance < Double($0.distance)! }.first ?? allCarrots.last!
    }
}


extension Carrot: Equatable {
    static func ==(lhs: Carrot, rhs: Carrot) -> Bool {
        return lhs.name == rhs.name
    }
}
