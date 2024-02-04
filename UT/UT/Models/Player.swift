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
    @Published var itemInfo: ItemInfo?
    
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
        case line_id, itemdesign
        case totalStats = "total_stats"
        case userrating, altimage
        case isUpgrade = "is_upgrade"
        case common_name = "common_name"
        case updatedate, appclass, cardtype, smallpreview, skillmoves, weakfoot, attackworkrate, defenseworkrate, heightft
    }
    //MARK: Init no args
    init(){
        self.id = ""
        self.lineid = ""
        self.cardname = ""
        self.name = ""
        self.urlname = ""
        self.rating = ""
        self.pid = ""
        self.position = ""
        self.position2 = ""
        self.position3 = ""
        self.position4 = ""
        self.nation = ""
        self.league = ""
        self.club = ""
        self.att1 = "0"
        self.att2 = "0"
        self.att3 = "0"
        self.att4 = "0"
        self.att5 = "0"
        self.att6 = "0"
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
        self.itemInfo = nil
    }
    
    //MARK: init with just player id
    init(withId playerId: String){
        self.id = playerId
        self.lineid = playerId
        self.cardname = "test"
        self.name = "superDeano"
        self.urlname = "mohamed-salah"
        self.rating = "99"
        self.pid = "183394"
        self.position = "CDM"
        self.position2 = "CM"
        self.position3 = "CB"
        self.position4 = "GK"
        self.nation = "77"
        self.league = "13"
        self.club = "19"
        self.att1 = "99"
        self.att2 = "99"
        self.att3 = "99"
        self.att4 = "99"
        self.att5 = "99"
        self.att6 = "99"
        self.rare = "1"
        self.fname = ""
        self.lname = ""
        self.dob = "69"
        self.height = "150"
        self.foot = "Right"
        self.traits = ""
        self.minprice = ""
        self.maxprice = ""
        self.totalStats = ""
        self.altimage = "50515042"
        self.isUpgrade = ""
        self.updatedate = ""
        self.appclass = ""
        self.cardtype = "card-24-bronze-nr"
        self.smallpreview = ""
        self.skillmoves = "5"
        self.weakfoot = "3"
        self.attackworkrate = "high"
        self.defenseworkrate = "high"
        self.heightft = "5'5\""
        self.itemInfo = ItemInfo(backgroundImage: "https://cdn.futwiz.com/assets/img/fc24/items/small/gold-if.png", color: "ffffff", names: [])
    }
    
    //MARK: init with SearchedPlayer
    init(for player: SearchedPlayer){
        self.id = player.lineid
        self.lineid = player.lineid
        self.cardname = player.cardname
        self.name = player.name
        self.urlname = player.urlName
        self.rating = player.rating
        self.pid = player.pid
        self.position = player.position
        self.position2 = player.position2
        self.position3 = player.position3
        self.position4 = player.position4
        self.nation = player.nation
        self.league = player.league
        self.club = player.club
        self.att1 = player.att1
        self.att2 = player.att2
        self.att3 = player.att3
        self.att4 = player.att4
        self.att5 = player.att5
        self.att6 = player.att6
        self.rare = player.rare
        self.fname = ""
        self.lname = ""
        self.dob = player.dob
        self.height = player.height
        self.foot = player.foot
        self.traits = ""
        self.minprice = ""
        self.maxprice = ""
        self.totalStats = ""
        self.altimage = player.altimage
        self.isUpgrade = ""
        self.updatedate = ""
        self.appclass = ""
        self.cardtype = player.cardtype
        self.smallpreview = player.smallpreview
        self.skillmoves = player.skillmoves
        self.weakfoot = player.weakfoot
        self.attackworkrate = player.attackworkrate
        self.defenseworkrate = player.defenseworkrate
        self.heightft = Player.convertCmIntoFt(val: player.height)
        
        if let i = ContentService.shared.itemManager.getItemInfo(for: cardtype) {
            self.itemInfo = i
        } else {
            self.itemInfo = ContentService.shared.itemManager.getItemInfo(for: smallpreview)
        }
        self.funcSetAttributeLabels()
    }
    
    //MARK: Required init
    public required init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        lineid = try values.decodeIfPresent(String.self,forKey: .lineid) ?? values.decode(String.self, forKey: .line_id)
        id = lineid
        cardname = try values.decode(String.self,forKey: .cardname)
        name = try values.decodeIfPresent(String.self,forKey: .name) ?? values.decode(String.self, forKey: .common_name)
        urlname = try values.decode(String.self,forKey: .urlname)
        rating = try values.decode(String.self,forKey: .rating)
        pid = try values.decode(String.self, forKey: .pid)
        position = try values.decode(String.self, forKey: .position)
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
        totalStats = try values.decodeIfPresent(String.self,forKey: .totalStats) ?? ""
        altimage = try values.decode(String?.self,forKey: .altimage)
        isUpgrade = try values.decodeIfPresent(String.self,forKey: .isUpgrade) ?? ""
        updatedate = try values.decodeIfPresent(String?.self,forKey: .updatedate) ?? ""
        appclass = try values.decode(String.self,forKey: .appclass)
        cardtype = try values.decodeIfPresent(String.self,forKey: .cardtype) ?? values.decodeIfPresent(String.self, forKey: .itemdesign) ?? ""
        smallpreview = try values.decode(String.self,forKey: .smallpreview)
        skillmoves = try values.decode(String.self,forKey: .skillmoves)
        weakfoot = try values.decode(String.self,forKey: .weakfoot)
        attackworkrate = try values.decode(String.self,forKey: .attackworkrate)
        defenseworkrate = try values.decode(String.self,forKey: .defenseworkrate)
        heightft = try values.decodeIfPresent(String.self,forKey: .heightft) ?? Player.convertCmIntoFt(val: height)
        if let i = ContentService.shared.itemManager.getItemInfo(for: cardtype) {
            itemInfo = i
        } else {
            itemInfo = ContentService.shared.itemManager.getItemInfo(for: smallpreview)
        }
        funcSetAttributeLabels()
    }
    
    
    //MARK: Attribute Label Func
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
    
    //MARK: Card Name Func
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
    
    public func setItem(item: ItemInfo) -> Player {
        self.itemInfo = item
        return self
    }
    
    //MARK: Alt Positions Func
    public func getAltPositions() -> String {
        var positions = ""
        if self.position2 != nil && self.position2 != "" {
            positions.append(self.position2!)
        }
        if self.position3 != nil && self.position3 != "" {
            positions.append(", ")
            positions.append(self.position3!)
        }
        if self.position4 != nil && self.position4 != "" {
            positions.append(", ")
            positions.append(self.position4!)
        }
        return positions //== "" ? "N/A" : positions
    }
}

//MARK: Extension 
extension Player {
    //    func encode(from decoder: Decoder) throws {
    //        let values = try decoder.container(keyedBy: CodingKeys.self)
    //
    //    }
    public static func convertCmIntoFt(val: String) -> String {
        guard let valInCm = Float(val) else { return "" }
        let footFloatVal = valInCm / 30.48
        let remFootVal = footFloatVal.truncatingRemainder(dividingBy: 1)
        let footVal = Int(remFootVal * 12)
        return "\(Int(footFloatVal))'\(footVal)\""
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

