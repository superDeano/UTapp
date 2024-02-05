//
//  SBC.swift
//  UT
//
//  Created by Dean Chong San on 2024-02-04.
//

import Foundation

class SBC: Decodable {
    var numChallenges: String
    var id: String
    var name: String
    var description: String
    var expiring: String
    var logo: String
    var new: Bool
    var repeatable: String
    var tag: String
    
    init() {
        self.numChallenges = "1"
        self.id = "1"
        self.name = "Test SBC Name"
        self.description = "Test SBC Description"
        self.expiring = "Never"
        self.logo = "10000899-eee2ff57-27b1"
        self.new = true
        self.repeatable = "99"
        self.tag = "Upgrades"
    }
    
    enum CodingKeys: String, CodingKey {
        case numChallenges = "subsbcs"
        case id, repeatable, logo, tag, new
        case name = "sbc_name"
        case description = "sbc_description"
        case expiring = "expires"
        
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        numChallenges = try values.decodeIfPresent(String.self, forKey: .numChallenges) ?? "1"
        name = try values.decode(String.self, forKey: .name)
        id = try values.decode(String.self, forKey: .id)
        description = try values.decode(String.self, forKey: .description)
        expiring = try values.decode(String.self, forKey: .expiring)
        logo = try values.decode(String.self, forKey: .logo)
        new = try values.decode(Int.self, forKey: .new) == 1
        repeatable = try values.decode(String.self, forKey: .repeatable)
        tag = try values.decode(String.self, forKey: .tag)
    }
}
