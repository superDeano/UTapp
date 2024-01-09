//
//  SearchedPlayer.swift
//  UT
//
//  Created by Dean Chong San on 2024-01-08.
//

import Foundation


class SearchedPlayer: Decodable, Identifiable {
    let lineid: String
    let pid: String
    let cardname: String
    let name: String
    let urlName: String
    let club: String
    let dob: String
    let league: String
    let height: String
    let nation: String
    let rating:  String
    let cardtype: String
    let rare: String
    let position: String
    let position2 : String?
    let position3 : String?
    let position4 : String?
    let altimage: String?
    let att1: String
    let att2: String
    let att3: String
    let att4: String
    let att5: String
    let att6: String
    private let workrates: String
    let attackworkrate: String
    let defenseworkrate: String
    let skillmoves: String
    let weakfoot: String
    let foot: String
    
    enum CodingKeys: String, CodingKey {
        case lineid, pid, cardname, name, dob
        case urlName = "urlname"
        case club, league, nation, rating
        case rare, cardtype, altimage, position
        case position2, position3, position4
        case att1, att2, att3, att4, att5, att6
        case skillmoves, weakfoot, workrates
        case height, foot
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        dob = try container.decode(String.self, forKey: .dob)
        lineid = try container.decode(String.self, forKey: .lineid)
        pid = try container.decode(String.self, forKey: .pid)
        cardname = try container.decode(String.self, forKey: .cardname)
        name = try container.decode(String.self, forKey: .name)
        urlName = try container.decode(String.self, forKey: .urlName)
        club = try container.decode(String.self, forKey: .club)
        league = try container.decode(String.self, forKey: .league)
        nation = try container.decode(String.self, forKey: .nation)
        rating = try container.decode( String.self, forKey: .rating)
        cardtype = try container.decode(String.self, forKey: .cardtype)
        rare = try container.decode(String.self, forKey: .rare)
        altimage = try container.decode(String?.self, forKey: .altimage)
        position = try container.decode( String.self, forKey: .position)
        position2 = try container.decode( String?.self, forKey: .position2)
        position3 = try container.decode( String?.self, forKey: .position3)
        position4 = try container.decode( String?.self, forKey: .position4)
        att1 = try container.decode(String.self, forKey: .att1)
        att2 = try container.decode(String.self, forKey: .att2)
        att3 = try container.decode(String.self, forKey: .att3)
        att4 = try container.decode(String.self, forKey: .att4)
        att5 = try container.decode(String.self, forKey: .att5)
        att6 = try container.decode(String.self, forKey: .att6)
        workrates = try container.decode(String.self, forKey: .workrates)
        let workratesSplit = workrates.split(separator: "-", maxSplits: 2)
        attackworkrate = String(workratesSplit[0]).uppercased()
        defenseworkrate = String(workratesSplit[1]).uppercased()
        height = try container.decode(String.self, forKey: .height)
        skillmoves = try container.decode(String.self, forKey: .skillmoves)
        weakfoot = try container.decode(String.self, forKey: .weakfoot)
        foot = try container.decode(String.self, forKey: .foot)
    }
    
}
