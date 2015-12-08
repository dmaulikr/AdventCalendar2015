//
//  Food.swift
//  JSONCodable
//
//  Created by Matthew Cheok on 18/10/15.
//
//

import Foundation
import JSONCodable

enum Cuisine: String {
    case Mexican
    case Italian
    case German
    case French
    case Pizza
    case Barbecue
    case Chinese
    case Japanese
    case Korean
    case Thai
}

struct Food: Equatable {
    let name: String
    let cuisines: [Cuisine]
}

func ==(lhs: Food, rhs: Food) -> Bool {
    return lhs.name == rhs.name && lhs.cuisines == rhs.cuisines
}

extension Food: JSONCodable {
    init?(JSONDictionary: JSONObject) {
        let decoder = JSONDecoder(object: JSONDictionary)
        do {
            name = try decoder.decode("name")
            cuisines = try decoder.decode("cuisines")
        }
        catch {
            return nil
        }
    }
    
    func toJSON() throws -> AnyObject {
        return try JSONEncoder.create({ (encoder) -> Void in
            try encoder.encode(name, key: "name")
            try encoder.encode(cuisines, key: "cuisines")
        })
    }
}