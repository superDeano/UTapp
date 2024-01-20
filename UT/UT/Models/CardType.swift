//
//  CardType.swift
//  UT
//
//  Created by Dean Chong San on 2024-01-20.
//

import Foundation


class CardType: Decodable, Identifiable {
    var rare: String
    var name: String
    var item: String
    
    enum CodingKeys: CodingKey {
    case rare, item, name
    }
    
    required init(decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        rare = try container.decode(String.self, forKey: .rare)
        item = try container.decode(String.self, forKey: .item)
        if item.contains(try Regex("gold")) {
            name = "Gold \(try container.decode(String.self, forKey: .name))"
        } else {
            name = try container.decode(String.self, forKey: .name)
        }
        
        
    }
}
