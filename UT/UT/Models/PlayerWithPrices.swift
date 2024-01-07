//
//  PlayerWithPrices.swift
//  UT
//
//  Created by Dean Chong San on 2024-01-05.
//

import Foundation

//class PlayerTest: Decodable {
//    let playerWithPrices: PlayerStats
//
//    enum CodingKeys: String, CodingKey {
//        case playerWithPrices = "player"
//    }
//
//    init() {
//        self.playerWithPrices = PlayerStats()
//    }
//
//    required init(from decoder: Decoder) throws {
//        let value = try decoder.container(keyedBy: CodingKeys.self)
//        playerWithPrices = try value.decode(PlayerStats.self, forKey: .playerWithPrices)
//    }
//}

class RootLowestBin: Decodable {
    let lowestBin: LowestBin
    
    enum codingKey:String, CodingKey {
        case lowestBin = "lowestbin"
    }
    
    init() {
        self.lowestBin = LowestBin()
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: codingKey.self)
        lowestBin = try container.decode(LowestBin.self, forKey: .lowestBin)
    }
}

class RootPlayerStats: Decodable {
    let playerStats: PlayerStats
    
    enum codingKey:String, CodingKey {
        case playerStats = "player"
    }
    
    init() {
        self.playerStats = PlayerStats()
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: codingKey.self)
        playerStats = try container.decode(PlayerStats.self, forKey: .playerStats)
    }
}



class PlayerStats: Decodable {
    
    let accelerate: String?
    let sex: String?
    let playstyles: String?
    let playstylesPlus: String?
    let agility, balance, jumping, reactions: String?
    let sprintspeed, stamina, strength, aggression: String?
    let positioning, tactaware, vision, ballcontrol: String?
    let crossing, curve, dribbling, finishing: String?
    let fkacc, headingacc, longpass, longshot: String?
    let marking, penalties, shortpass, shotpower: String?
    let slidetackle, standingtackle, volleys: String?
    let att1, att2, att3, composure: String?
    let att4, att5, att6, acceleration: String?
    
    enum CodingKeys: String, CodingKey {
        case accelerate, sex, playstyles
        case playstylesPlus = "playstyles_plus"
        case att1, att2, att3, att4, att5, att6, acceleration, agility, balance, jumping, reactions, sprintspeed, stamina, strength, aggression, positioning, tactaware, vision, ballcontrol, crossing, curve, dribbling, finishing, fkacc, headingacc, longpass, longshot, marking, penalties, shortpass, shotpower, slidetackle, standingtackle, volleys, composure
    }
    
    init() {
        self.accelerate = ""
        self.sex = ""
        self.playstyles = ""
        self.playstylesPlus = ""
        self.att1 = ""
        self.att2 = ""
        self.att3 = ""
        self.att4 = ""
        self.att5 = ""
        self.att6 = ""
        self.acceleration = ""
        self.agility = ""
        self.balance = ""
        self.jumping = ""
        self.reactions = ""
        self.sprintspeed = ""
        self.stamina = ""
        self.strength = ""
        self.aggression = ""
        self.positioning = ""
        self.tactaware = ""
        self.vision = ""
        self.ballcontrol = ""
        self.crossing = ""
        self.curve = ""
        self.dribbling = ""
        self.finishing = ""
        self.fkacc = ""
        self.headingacc = ""
        self.longpass = ""
        self.longshot = ""
        self.marking = ""
        self.penalties = ""
        self.shortpass = ""
        self.shotpower = ""
        self.slidetackle = ""
        self.standingtackle = ""
        self.volleys = ""
        self.composure = ""
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        accelerate = try values.decode(String?.self, forKey: .accelerate)
        sex = try values.decode(String?.self, forKey: .sex)
        playstyles = try values.decode(String?.self, forKey: .playstyles)
        playstylesPlus = try values.decode(String?.self, forKey: .playstylesPlus)
        att1 = try values.decode(String.self,forKey: .att1)
        att2 = try values.decode(String.self,forKey: .att2)
        att3 = try values.decode(String.self,forKey: .att3)
        att4 = try values.decode(String.self,forKey: .att4)
        att5 = try values.decode(String.self,forKey: .att5)
        att6 = try values.decode(String.self,forKey: .att6)
        acceleration = try values.decode(String.self,forKey: .acceleration)
        agility = try values.decode(String.self,forKey: .agility)
        balance = try values.decode(String.self,forKey: .balance)
        jumping = try values.decode(String.self,forKey: .jumping)
        reactions = try values.decode(String.self,forKey: .reactions)
        sprintspeed = try values.decode(String.self,forKey: .sprintspeed)
        stamina = try values.decode(String.self,forKey: .stamina)
        strength = try values.decode(String.self,forKey: .strength)
        aggression = try values.decode(String.self,forKey: .aggression)
        positioning = try values.decode(String.self,forKey: .positioning)
        tactaware = try values.decode(String.self,forKey: .tactaware)
        vision = try values.decode(String.self,forKey: .vision)
        ballcontrol = try values.decode(String.self,forKey: .ballcontrol)
        crossing = try values.decode(String.self,forKey: .crossing)
        curve = try values.decode(String.self,forKey: .curve)
        dribbling = try values.decode(String.self,forKey: .dribbling)
        finishing = try values.decode(String.self,forKey: .finishing)
        fkacc = try values.decode(String.self,forKey: .fkacc)
        headingacc = try values.decode(String.self,forKey: .headingacc)
        longpass = try values.decode(String.self,forKey: .longpass)
        longshot = try values.decode(String.self,forKey: .longshot)
        marking = try values.decode(String.self,forKey: .marking)
        penalties = try values.decode(String.self,forKey: .penalties)
        shortpass = try values.decode(String.self,forKey: .shortpass)
        shotpower = try values.decode(String.self,forKey: .shotpower)
        slidetackle = try values.decode(String.self,forKey: .slidetackle)
        standingtackle = try values.decode(String.self,forKey: .standingtackle)
        volleys = try values.decode(String.self,forKey: .volleys)
        composure = try values.decode(String.self, forKey: .composure)
//        try super.init(from: decoder)
        //        } catch {
        //            super.init()
        //            print(error)
        //        }
//                try super.init(from: superDecoder)
    }
    
}



class Price: Decodable {
    let lowestBin : LowestBin
    
    enum CodingKeys: String, CodingKey {
        case lowestBin = "lowestbin"
    }
    
    init(){
        self.lowestBin = LowestBin()
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        lowestBin = try values.decode(LowestBin.self, forKey: .lowestBin)
    }
    
}

class LowestBin: Decodable {
    let bin: String?
    let ud: String?
    
    enum CodingKeys: CodingKey {
        case bin, ud
    }
    
    init() {
        self.bin = ""
        self.ud = ""
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        bin = try values.decode(String?.self, forKey: .bin)
        ud = try values.decode(String?.self, forKey: .ud)
    }
}