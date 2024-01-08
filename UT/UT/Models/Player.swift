//
//  Player.swift
//  UT
//
//  Created by Dean Chong San on 2024-01-03.
//

import Foundation

// MARK: - Player

class Player: Decodable, Identifiable, Equatable, ObservableObject, Observable {
    nonisolated static func == (lhs: Player, rhs: Player) -> Bool {
        lhs.lineid == rhs.lineid
    }
    
    let lineid, cardname, name, urlname: String
    let rating, pid, position, nation, league: String
    let position3, position4, position2: String?
    let club, att1, att2, att3: String
    let att4, att5, att6: String
    let rare: String
    let fname, lname, dob, height: String
    let foot: String
    let minprice, maxprice: String
    let traits, altimage: String?
    let totalStats: String
    let isUpgrade, updatedate: String?
    let appclass, cardtype, smallpreview, skillmoves: String
    let weakfoot, attackworkrate, defenseworkrate, heightft: String
    
    var id: String
    var att1Label = "PAC"
    var att2Label = "SHO"
    var att3Label = "PAS"
    var att4Label = "DRI"
    var att5Label = "DEF"
    var att6Label = "PHY"
    

    @Published public var stats: PlayerStats?    
    @Published public var lowestBin: LowestBin?
    
    enum CodingKeys: String, CodingKey {
        case lineid, cardname, name, urlname, rating, pid, position, position2, position3, position4, nation, league, club, att1, att2, att3, att4, att5, att6, rare, fname, lname, dob, height, foot, traits, fut, minprice, maxprice
        
        case totalStats = "total_stats"
        case userrating, altimage
        case isUpgrade = "is_upgrade"
        case updatedate, appclass, cardtype, smallpreview, skillmoves, weakfoot, attackworkrate, defenseworkrate, heightft
    }
    //MARK: Init no args
    init(){
        self.id = ""
        self.lineid = ""
        self.cardname = "superDeano"
        self.name = ""
        self.urlname = ""
        self.rating = "99"
        self.pid = ""
        self.position = "CDM"
        self.position2 = ""
        self.position3 = ""
        self.position4 = ""
        self.nation = "70"
        self.league = "13"
        self.club = "9"
        self.att1 = "99"
        self.att2 = "99"
        self.att3 = "99"
        self.att4 = "99"
        self.att5 = "99"
        self.att6 = "99"
        self.rare = "0"
        self.fname = ""
        self.lname = ""
        self.dob = ""
        self.height = ""
        self.foot = ""
        self.traits = ""
        self.minprice = ""
        self.maxprice = ""
        self.totalStats = ""
        self.altimage = ""
        self.isUpgrade = ""
        self.updatedate = ""
        self.appclass = ""
        self.cardtype = "card-24-bronze-nr"
        self.smallpreview = ""
        self.skillmoves = ""
        self.weakfoot = ""
        self.attackworkrate = ""
        self.defenseworkrate = ""
        self.heightft = ""
    }
    
    //MARK: Init all args
    init(lineid: String, cardname: String, name: String, urlname: String, rating: String, pid: String, position: String, position2: String?, position3: String?, position4: String?, nation: String, league: String, club: String, att1: String, att2: String, att3: String, att4: String, att5: String, att6: String, rare: String, fname: String, lname: String, dob: String, height: String, foot: String, traits: String?, minprice: String, maxprice: String, totalStats: String, altimage: String?, isUpgrade: String?, updatedate: String?, appclass: String, cardtype: String, smallpreview: String, skillmoves: String, weakfoot: String, attackworkrate: String, defenseworkrate: String, heightft: String) {
        
        self.id = lineid
        self.lineid = lineid
        self.cardname = cardname
        self.name = name
        self.urlname = urlname
        self.rating = rating
        self.pid = pid
        self.position = position
        self.position2 = position2
        self.position3 = position3
        self.position4 = position4
        self.nation = nation
        self.league = league
        self.club = club
        self.att1 = att1
        self.att2 = att2
        self.att3 = att3
        self.att4 = att4
        self.att5 = att5
        self.att6 = att6
        self.rare = rare
        self.fname = fname
        self.lname = lname
        self.dob = dob
        self.height = height
        self.foot = foot
        self.traits = traits
        self.minprice = minprice
        self.maxprice = maxprice
        self.totalStats = totalStats
        self.altimage = altimage
        self.isUpgrade = isUpgrade
        self.updatedate = updatedate
        self.appclass = appclass
        self.cardtype = cardtype
        self.smallpreview = smallpreview
        self.skillmoves = skillmoves
        self.weakfoot = weakfoot
        self.attackworkrate = attackworkrate
        self.defenseworkrate = defenseworkrate
        self.heightft = heightft
        
        self.funcSetAttributeLabels()
    }
    
    //MARK: Required init
    public required init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        lineid = try values.decode(String.self,forKey: .lineid)
        id = lineid
        cardname = try values.decode(String.self,forKey: .cardname)
        name = try values.decode(String.self,forKey: .name)
        urlname = try values.decode(String.self,forKey: .urlname)
        rating = try values.decode(String.self,forKey: .rating)
        pid = try values.decode(String.self,forKey: .pid)
        position = try values.decode(String.self,forKey: .position)
        position2 = try values.decode(String?.self,forKey: .position2)
        position3 = try values.decode(String?.self,forKey: .position3)
        position4 = try values.decode(String?.self, forKey: .position4)
        nation = try values.decode(String.self,forKey: .nation)
        league = try values.decode(String.self,forKey: .league)
        club = try values.decode(String.self,forKey: .club)
        att1 = try values.decode(String.self,forKey: .att1)
        att2 = try values.decode(String.self,forKey: .att2)
        att3 = try values.decode(String.self,forKey: .att3)
        att4 = try values.decode(String.self,forKey: .att4)
        att5 = try values.decode(String.self,forKey: .att5)
        att6 = try values.decode(String.self,forKey: .att6)
        rare = try values.decode(String.self,forKey: .rare)
        fname = try values.decode(String.self,forKey: .fname)
        lname = try values.decode(String.self,forKey: .lname)
        dob = try values.decode(String.self,forKey: .dob)
        height = try values.decode(String.self,forKey: .height)
        foot = try values.decode(String.self,forKey: .foot)
        traits = try values.decode(String?.self,forKey: .traits)
        minprice = try values.decode(String.self,forKey: .minprice)
        maxprice = try values.decode(String.self,forKey: .maxprice)
        totalStats = try values.decode(String.self,forKey: .totalStats)
        altimage = try values.decode(String?.self,forKey: .altimage)
        isUpgrade = try values.decode(String?.self,forKey: .isUpgrade)
        updatedate = try values.decode(String?.self,forKey: .updatedate)
        appclass = try values.decode(String.self,forKey: .appclass)
        cardtype = try values.decode(String.self,forKey: .cardtype)
        smallpreview = try values.decode(String.self,forKey: .smallpreview)
        skillmoves = try values.decode(String.self,forKey: .skillmoves)
        weakfoot = try values.decode(String.self,forKey: .weakfoot)
        attackworkrate = try values.decode(String.self,forKey: .attackworkrate)
        defenseworkrate = try values.decode(String.self,forKey: .defenseworkrate)
        heightft = try values.decode(String.self,forKey: .heightft)
        
        funcSetAttributeLabels()
    }
    
    private func funcSetAttributeLabels() {
        if self.position == "GK" {
            self.att1Label = "DIV"
            self.att2Label = "HAN"
            self.att3Label = "KIC"
            self.att4Label = "REF"
            self.att5Label = "SPE"
            self.att6Label = "POS"
        } else {
            self.att1Label = "PAC"
            self.att2Label = "SHO"
            self.att3Label = "PAS"
            self.att4Label = "DRI"
            self.att5Label = "DEF"
            self.att6Label = "PHY"
        }
    }
    
    public func getCardName() -> String {
        let cardRarity = Int(self.rare)!
        var cardName = ""
        if cardRarity < 2 {
            if self.cardtype.contains("gold") {
                cardName = "fc24-gold-\(cardRarity + 1)"
            } else if self.cardtype.contains("silver") {
                cardName = "fc24-silver-\(cardRarity + 1)"
            } else {
                cardName = "fc24-bronze-\(cardRarity + 1)"
            }
        } else if cardRarity == 3 {
            if self.cardtype.contains("gold") {
                cardName = "gold-if"
            } else if self.cardtype.contains("silver") {
                cardName = "silver-if"
            } else {
                cardName = "bronze-if"
            }
        } else {
            return ""
        }
        return "Cards/\(cardName)"
    }
}

extension Player {
    //    func encode(from decoder: Decoder) throws {
    //        let values = try decoder.container(keyedBy: CodingKeys.self)
    //
    //    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

