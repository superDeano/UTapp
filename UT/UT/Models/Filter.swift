//
//  Filter.swift
//  UT
//
//  Created by Dean Chong San on 2024-01-12.
//

import Foundation

class Filter: ObservableObject {
    private let ANPERCENT = "&"
    private let NATIONS = "nations[]="
    private let LEAGUES = "leagues[]="
    private let TEAMS = "teams[]="
    private let DEF_WR = "defworkrates[]="
    private let ATT_WR = "attworkrates[]="
    private let POSITIONS = "positions[]="
    private let WEAK_FOOT = "weakfoot[]="
    private let SKILL_MOVES = "skills[]="
    
    private let MIN_PACE = "minatt1="
    private let MAX_PACE = "maxatt1="
    private let MIN_SHOOTING = "minatt2="
    private let MAX_SHOOTING = "maxatt2="
    private let MIN_PASSING = "minatt3="
    private let MAX_PASSING = "maxatt3="
    private let MIN_DRIBBLING = "minatt4="
    private let MAX_DRIBBLING = "maxatt4="
    private let MIN_DEFENSE = "minatt5="
    private let MAX_DEFENSE = "maxatt5="
    private let MIN_PHYSICAL = "minatt6="
    private let MAX_PHYSICAL = "maxatt6="
    private let MIN_RATING = "minrating="
    private let MAX_RATING = "maxrating="
    private let ACCELERATE = "accelerate="
    private let MAX_BALANCE = "maxbalance="
    private let MIN_BALANCE = "minbalance="
    private let MAX_FK_ACC = "maxfkacc="
    private let MIN_FK_ACC = "minfkacc="
    private let MIN_STANDING_TACKLE = "minstandingtackle="
    private let MAX_STANDING_TACKLE = "maxstandingtackle="
    private let MIN_SLIDING_TACKLE = "minslidingtackle="
    private let MAX_SLIDING_TACKLE = "maxslidingtackle="
    private let MIN_BALL_CONTROL = "minballcontrol="
    private let MAX_BALL_CONTROL = "maxballcontrol="
    private let MAX_SHORT_PASS = "maxshortpass="
    private let MIN_SHORT_PASS = "minshortpass="
    private let MIN_VOLLEYS = "minvolleys="
    private let MAX_VOLLEYS = "maxvolleys="
    private let MAX_VISION = "maxvision="
    private let MIN_VISION = "minvision="
    private let MIN_ACCELERATION = "minacceleration="
    private let MAX_ACCELERATION = "maxacceleration="
    private let MIN_AGILITY = "minagility="
    private let MAX_AGILITY = "maxagility="
    private let MIN_COMPOSURE = "mincomposure="
    private let MAX_COMPOSURE = "maxcomposure="
    private let MIN_LONG_PASS = "minlongpass="
    private let MAX_LONG_PASS = "maxlongpass="
    private let MIN_CURVE = "mincurve="
    private let MAX_CURVE = "maxcurve="
    private let MIN_CROSSING = "mincrossing="
    private let MAX_CROSSING = "maxcrossing="
    private let MIN_AGRESSION = "minagression="
    private let MAX_AGRESSION = "maxagression="
    private let MAX_SPRINT = "maxsprintspeed="
    private let MIN_SPRINT = "minsprintspeed="
    private let MIN_MARKING = "minmarking="
    private let MAX_MARKING = "maxmarking="
    private let MAX_POSITION = "maxpositioning="
    private let MIN_POSITION = "minpositioning="
    private let MAX_FINISH = "maxfinishing="
    private let MIN_FINISH = "minfinishing="
    private let MAX_SHOT_POWER = "maxshotpower="
    private let MIN_SHOT_POWER = "minshotpower="
    private let MAX_LONG_SHOT = "maxlongshot="
    private let MIN_LONG_SHOT = "minlongshot="
    private let MIN_PENALTIES = "minpenalties="
    private let MAX_PENALTIES = "maxpenalties="
    private let MAX_REACTION = "maxreactions="
    private let MIN_REACTION = "minreactions="
    private let MAX_INTERCEPTION = "maxtactaware="
    private let MIN_INTERCEPTION = "mintactaware="
    private let MIN_HEAD_ACC = "minheadacc="
    private let MAX_HEAD_ACC = "maxheadacc="
    private let MAX_JUMPING = "maxjumping="
    private let MIN_JUMPING = "minjumping="
    private let MIN_STAMINA = "minstamina="
    private let MAX_STAMINA = "maxstamina="
    private let MAX_STRENGTH = "maxstrength="
    private let MIN_STRENGTH = "minstrength="
    
    
    private var allLeagues: [GenericKeyValue] = []
    private var allNations: [GenericKeyValue] = []
    private var allPositions: [GenericValue] = []
    private var workRates: [GenericValue] = []
    private var starRatings: [GenericValue] = []
    private var cardVersions: [GenericKeyValue] = []
    
    @Published public var selectedLeagues: Set<GenericKeyValue> = Set()
    @Published public var selectedTeams: Set<GenericKeyValue> = Set()
    @Published public var selectedPositions: Set<GenericValue> = Set()
    @Published public var selectedAttWorkRates: Set<GenericValue> = Set()
    @Published public var selectedDefWorkRates: Set<GenericValue> = Set()
    @Published public var selectedSkills: Set<GenericValue> = Set()
    @Published public var selectedWeakFoots: Set<GenericValue> = Set()
    @Published public var selectedNations: Set<GenericKeyValue> = Set()
    @Published public var selectedVersions: Set<GenericKeyValue> = Set()
    @Published public var selectedAccelerate: String? = nil
    
    @Published public var selectedMinRating: Double = 1
    @Published public var selectedMaxRating: Double = 99
//    Pace Stats
    @Published public var selectedMinPace: Double = 1
    @Published public var selectedMaxPace: Double = 99
    @Published public var selectedMinAcceleration: Double = 1
    @Published public var selectedMaxAcceleration: Double = 99
    @Published public var selectedMinSprint: Double = 1
    @Published public var selectedMaxSprint: Double = 99
    
//    Shooting
    @Published public var selectedMinShooting: Double = 1
    @Published public var selectedMaxShooting: Double = 99
    @Published public var selectedMinPosition: Double = 1
    @Published public var selectedMaxPosition: Double = 99
    @Published public var selectedMinFinishing: Double = 1
    @Published public var selectedMaxFinishing: Double = 99
    @Published public var selectedMinShotPower: Double = 1
    @Published public var selectedMaxShotPower: Double = 99
    @Published public var selectedMinLongShot: Double = 1
    @Published public var selectedMaxLongShot: Double = 99
    @Published public var selectedMinVolleys: Double = 1
    @Published public var selectedMaxVolleys: Double = 99
    @Published public var selectedMinPenalties: Double = 1
    @Published public var selectedMaxPenalties: Double = 99
    
//    Passing
    @Published public var selectedMinPassing: Double = 1
    @Published public var selectedMaxPassing: Double = 99
    @Published public var selectedMinVision: Double = 1
    @Published public var selectedMaxVision: Double = 99
    @Published public var selectedMinCrossing: Double = 1
    @Published public var selectedMaxCrossing: Double = 99
    @Published public var selectedMinFkAcc: Double = 1
    @Published public var selectedMaxFkAcc: Double = 99
    @Published public var selectedMinShortPassing: Double = 1
    @Published public var selectedMaxShortPassing: Double = 99
    @Published public var selectedMinLongPassing: Double = 1
    @Published public var selectedMaxLongPassing: Double = 99
    @Published public var selectedMinCurve: Double = 1
    @Published public var selectedMaxCurve: Double = 99
    
//    Dribbling
    @Published public var selectedMinDribbling: Double = 1
    @Published public var selectedMaxDribbling: Double = 99
    @Published public var selectedMinAgility: Double = 1
    @Published public var selectedMaxAgility: Double = 99
    @Published public var selectedMinBalance: Double = 1
    @Published public var selectedMaxBalance: Double = 99
    @Published public var selectedMinReaction: Double = 1
    @Published public var selectedMaxReaction: Double = 99
    @Published public var selectedMinBallControl: Double = 1
    @Published public var selectedMaxBallControl: Double = 99
    
//    Defending
    @Published public var selectedMinDefending: Double = 1
    @Published public var selectedMaxDefending: Double = 99
    @Published public var selectedMinInterception: Double = 1
    @Published public var selectedMaxInterception: Double = 99
    @Published public var selectedMinHeadAcc: Double = 1
    @Published public var selectedMaxHeadAcc: Double = 99
    @Published public var selectedMinMarking: Double = 1
    @Published public var selectedMaxMarking: Double = 99
    @Published public var selectedMinStandingTackle: Double = 1
    @Published public var selectedMaxStandingTackle: Double = 99
    @Published public var selectedMinSlidingTackle: Double = 1
    @Published public var selectedMaxSlidingTackle: Double = 99
//    Physical
    @Published public var selectedMinPhysical: Double = 1
    @Published public var selectedMaxPhysical: Double = 99
    @Published public var selectedMinJumping: Double = 1
    @Published public var selectedMaxJumping: Double = 99
    @Published public var selectedMinStamina: Double = 1
    @Published public var selectedMaxStamina: Double = 99
    @Published public var selectedMinStrength: Double = 1
    @Published public var selectedMaxStrength: Double = 99
    @Published public var selectedMinAgression: Double = 1
    @Published public var selectedMaxAgression: Double = 99
    @Published public var selectedMinComposure: Double = 1
    @Published public var selectedMaxComposure: Double = 99
    
    init() {
        self.getCardVersionsRemotely()
        self.allLeagues = computeAllLeagues()
        self.allPositions = computeAllPositions()
        self.allNations = computeAllNations()
        self.starRatings = computeStarRatings()
        self.workRates = computeAllWorkRates()
    }
    
    public func getCardVersionsRemotely() {
        ContentService.shared.getCardVersions { cardVersions in
            DispatchQueue.main.async {
                self.cardVersions = cardVersions
            }
        }
    }
    
    public func getCardVersions() -> [GenericKeyValue] {
        return self.cardVersions
    }
    
    private func computeAllPositions() -> [GenericValue] {
        return [GenericValue(value: "Attackers"),GenericValue(value: "Midfielders"),GenericValue(value: "Defenders"), GenericValue(value: "GK"), GenericValue(value: "LB"), GenericValue(value: "LWB"), GenericValue(value: "CB"), GenericValue(value: "RB"), GenericValue(value: "RWB"), GenericValue(value: "CDM"), GenericValue(value: "CM"), GenericValue(value: "CAM"), GenericValue(value: "LM"), GenericValue(value: "RM"), GenericValue(value: "LW"), GenericValue(value: "RW"), GenericValue(value: "CF"), GenericValue(value: "ST")]
    }
    
    public func getAllPositions() -> [GenericValue]{
        return self.allPositions
    }
    
    private func computeAllLeagues() -> [GenericKeyValue] {
        return Leagues.leagues.map { (k: String, val: String) in
            GenericKeyValue(key: k, value: val)
        }.sorted { obj1, obj2 in
            obj1.value < obj2.value
        }
    }
    
    func getAllLeagues() -> [GenericKeyValue] {
        return self.allLeagues
    }
    
    public func getSpecificTeams() -> [GenericKeyValue] {
        var teams = [GenericKeyValue]()
        for (_, val) in self.selectedLeagues.enumerated() {
            let teamsInLeague: [String] = Leagues.leaguesAndClubs[val.id] ?? []
            for teamId in teamsInLeague {
                teams.append(GenericKeyValue(key: teamId, value: Clubs.teams[teamId] ?? ""))
            }
        }
        return teams
    }
    
    private func computeAllWorkRates() -> [GenericValue]{
        //        <input type="checkbox" name="attworkrates[]" value="high" id="attwrhigh" />
        //        <input type="checkbox" name="attworkrates[]" value="med" id="attwrmed" />
        //        <input type="checkbox" name="attworkrates[]" value="low" id="attwrlow" />
        //        <input type="checkbox" name="defworkrates[]" value="high" id="defwrhigh" />
        //        <input type="checkbox" name="defworkrates[]" value="med" id="defwrmed" />
        //        <input type="checkbox" name="adeforkrates[]" value="low" id="defwrlow" />
        return [
            GenericValue(value: "high"),
            GenericValue(value: "med"),
            GenericValue(value: "low"),
        ]
    }
    
    public func getAllWorkRates() -> [GenericValue] {
        return self.workRates
    }
    
    private func computeAllNations() -> [GenericKeyValue] {
        return Nations.nations.map { (k: String, val: String) in
            GenericKeyValue(key: k, value: val)
        }.sorted(by: {$0.value < $1.value})
    }
    
    public func getAllNations() -> [GenericKeyValue]{
        return self.allNations
    }
    
    private func computeStarRatings() -> [GenericValue]{
        return [
            GenericValue(value: "5"),
            GenericValue(value: "4"),
            GenericValue(value: "3"),
            GenericValue(value: "2"),
            GenericValue(value: "1")
        ]
    }
    
    public func getStarRatings() -> [GenericValue]{
        return self.starRatings
    }
    
    func getQuery() -> String {
        var query = ""
        
        if let nationsQuery = getNationsQuery() {
            query.append(nationsQuery)
            query.append(self.ANPERCENT)
        }
        if let positionQuery = getPositionsQuery() {
            query.append(positionQuery)
            query.append(self.ANPERCENT)
        }
        if let leagueQuery = getLeaguesQuery() {
            query.append(leagueQuery)
            query.append(self.ANPERCENT)
        }
        if let teamsQuery = getTeamsQuery() {
            query.append(teamsQuery)
            query.append(self.ANPERCENT)
        }

        if let attWrQuery = getAttWorkRatesQuery() {
            query.append(attWrQuery)
            query.append(self.ANPERCENT)
        }
        if let defWrQuery = getDefWorkRatesQuery() {
            query.append(defWrQuery)
            query.append(self.ANPERCENT)
        }
        if let skillQuery = getSkillMovesQuery() {
            query.append(skillQuery)
            query.append(self.ANPERCENT)
        }
        if let weakFootQuery = getWeakFootQuery() {
            query.append(weakFootQuery)
            query.append(self.ANPERCENT)
        }
        //MARK: Pace
        query.append(self.MAX_PACE)
        query.append(String(format: "%.0f", self.selectedMaxPace))
        query.append(self.ANPERCENT)
        
        query.append(self.MIN_PACE)
        query.append(String(format: "%.0f", self.selectedMinPace))
        query.append(self.ANPERCENT)
        
        query.append(self.MAX_ACCELERATION)
        query.append(String(format: "%.0f", self.selectedMaxAcceleration))
        query.append(self.ANPERCENT)
        
        query.append(self.MIN_ACCELERATION)
        query.append(String(format: "%.0f", self.selectedMinAcceleration))
        query.append(self.ANPERCENT)
        
        query.append(self.MAX_SPRINT)
        query.append(String(format: "%.0f", self.selectedMaxSprint))
        query.append(self.ANPERCENT)
        
        query.append(self.MIN_SPRINT)
        query.append(String(format: "%.0f", self.selectedMinSprint))
        query.append(self.ANPERCENT)
        
        
        //MARK: Shooting
        query.append(self.MAX_SHOOTING)
        query.append(String(format: "%.0f", self.selectedMaxShooting))
        query.append(self.ANPERCENT)
        
        query.append(self.MIN_SHOOTING)
        query.append(String(format: "%.0f", self.selectedMinShooting))
        query.append(self.ANPERCENT)
        
        query.append(self.MAX_POSITION)
        query.append(String(format: "%.0f", self.selectedMaxPosition))
        query.append(self.ANPERCENT)
        
        query.append(self.MIN_POSITION)
        query.append(String(format: "%.0f", self.selectedMinPosition))
        query.append(self.ANPERCENT)
        
        query.append(self.MAX_FINISH)
        query.append(String(format: "%.0f", self.selectedMaxFinishing))
        query.append(self.ANPERCENT)
        
        query.append(self.MIN_FINISH)
        query.append(String(format: "%.0f", self.selectedMinFinishing))
        query.append(self.ANPERCENT)
        
        query.append(self.MAX_SHOT_POWER)
        query.append(String(format: "%.0f", self.selectedMaxShotPower))
        query.append(self.ANPERCENT)
        
        query.append(self.MIN_SHOT_POWER)
        query.append(String(format: "%.0f", self.selectedMinShotPower))
        query.append(self.ANPERCENT)
        
        query.append(self.MAX_LONG_SHOT)
        query.append(String(format: "%.0f", self.selectedMaxLongShot))
        query.append(self.ANPERCENT)
        
        query.append(self.MIN_LONG_SHOT)
        query.append(String(format: "%.0f", self.selectedMinLongShot))
        query.append(self.ANPERCENT)
        
        query.append(self.MAX_VOLLEYS)
        query.append(String(format: "%.0f", self.selectedMaxVolleys))
        query.append(self.ANPERCENT)
        
        query.append(self.MIN_VOLLEYS)
        query.append(String(format: "%.0f", self.selectedMinVolleys))
        query.append(self.ANPERCENT)
        
        query.append(self.MAX_PENALTIES)
        query.append(String(format: "%.0f", self.selectedMaxPenalties))
        query.append(self.ANPERCENT)
        
        query.append(self.MIN_PENALTIES)
        query.append(String(format: "%.0f", self.selectedMinPenalties))
        query.append(self.ANPERCENT)
        
        
        //MARK: Passing
        query.append(self.MAX_PASSING)
        query.append(String(format: "%.0f", self.selectedMaxPassing))
        query.append(self.ANPERCENT)
        
        query.append(self.MIN_PASSING)
        query.append(String(format: "%.0f", self.selectedMinPassing))
        query.append(self.ANPERCENT)
        
        query.append(self.MAX_VISION)
        query.append(String(format: "%.0f", self.selectedMaxVision))
        query.append(self.ANPERCENT)
        
        query.append(self.MIN_VISION)
        query.append(String(format: "%.0f", self.selectedMinVision))
        query.append(self.ANPERCENT)
        
        query.append(self.MAX_CROSSING)
        query.append(String(format: "%.0f", self.selectedMaxCrossing))
        query.append(self.ANPERCENT)
        
        query.append(self.MIN_CROSSING)
        query.append(String(format: "%.0f", self.selectedMinCrossing))
        query.append(self.ANPERCENT)
        
        query.append(self.MAX_FK_ACC)
        query.append(String(format: "%.0f", self.selectedMaxFkAcc))
        query.append(self.ANPERCENT)
        
        query.append(self.MIN_FK_ACC)
        query.append(String(format: "%.0f", self.selectedMinFkAcc))
        query.append(self.ANPERCENT)
        
        query.append(self.MAX_SHORT_PASS)
        query.append(String(format: "%.0f", self.selectedMaxShortPassing))
        query.append(self.ANPERCENT)
        
        query.append(self.MIN_SHORT_PASS)
        query.append(String(format: "%.0f", self.selectedMinShortPassing))
        query.append(self.ANPERCENT)
        
        query.append(self.MAX_LONG_PASS)
        query.append(String(format: "%.0f", self.selectedMaxLongPassing))
        query.append(self.ANPERCENT)
        
        query.append(self.MIN_LONG_PASS)
        query.append(String(format: "%.0f", self.selectedMinLongPassing))
        query.append(self.ANPERCENT)
        
        query.append(self.MAX_CURVE)
        query.append(String(format: "%.0f", self.selectedMaxCurve))
        query.append(self.ANPERCENT)
        
        query.append(self.MIN_CURVE)
        query.append(String(format: "%.0f", self.selectedMinCurve))
        query.append(self.ANPERCENT)
        
        //MARK: Dribbling
        query.append(self.MAX_DRIBBLING)
        query.append(String(format: "%.0f", self.selectedMaxDribbling))
        query.append(self.ANPERCENT)
        
        query.append(self.MIN_DRIBBLING)
        query.append(String(format: "%.0f", self.selectedMinDribbling))
        query.append(self.ANPERCENT)

        query.append(self.MAX_AGILITY)
        query.append(String(format: "%.0f", self.selectedMaxAgility))
        query.append(self.ANPERCENT)
        
        query.append(self.MIN_AGILITY)
        query.append(String(format: "%.0f", self.selectedMinAgility))
        query.append(self.ANPERCENT)
        
        query.append(self.MAX_BALANCE)
        query.append(String(format: "%.0f", self.selectedMaxBalance))
        query.append(self.ANPERCENT)
        
        query.append(self.MIN_BALANCE)
        query.append(String(format: "%.0f", self.selectedMinBalance))
        query.append(self.ANPERCENT)
        
        query.append(self.MAX_REACTION)
        query.append(String(format: "%.0f", self.selectedMaxReaction))
        query.append(self.ANPERCENT)
        
        query.append(self.MIN_REACTION)
        query.append(String(format: "%.0f", self.selectedMinReaction))
        query.append(self.ANPERCENT)
        
        query.append(self.MAX_BALL_CONTROL)
        query.append(String(format: "%.0f", self.selectedMaxBallControl))
        query.append(self.ANPERCENT)
        
        query.append(self.MIN_BALL_CONTROL)
        query.append(String(format: "%.0f", self.selectedMinBallControl))
        query.append(self.ANPERCENT)
        
        //MARK: Defense
        query.append(self.MAX_DEFENSE)
        query.append(String(format: "%.0f", self.selectedMaxDefending))
        query.append(self.ANPERCENT)
        
        query.append(self.MIN_DEFENSE)
        query.append(String(format: "%.0f", self.selectedMinDefending))
        query.append(self.ANPERCENT)
        
        query.append(self.MAX_INTERCEPTION)
        query.append(String(format: "%.0f", self.selectedMaxInterception))
        query.append(self.ANPERCENT)
        
        query.append(self.MIN_INTERCEPTION)
        query.append(String(format: "%.0f", self.selectedMinInterception))
        query.append(self.ANPERCENT)
        
        query.append(self.MAX_HEAD_ACC)
        query.append(String(format: "%.0f", self.selectedMaxHeadAcc))
        query.append(self.ANPERCENT)
        
        query.append(self.MIN_HEAD_ACC)
        query.append(String(format: "%.0f", self.selectedMinHeadAcc))
        query.append(self.ANPERCENT)
        
        query.append(self.MAX_MARKING)
        query.append(String(format: "%.0f", self.selectedMaxMarking))
        query.append(self.ANPERCENT)
        
        query.append(self.MIN_MARKING)
        query.append(String(format: "%.0f", self.selectedMinMarking))
        query.append(self.ANPERCENT)
        
        query.append(self.MAX_STANDING_TACKLE)
        query.append(String(format: "%.0f", self.selectedMaxStandingTackle))
        query.append(self.ANPERCENT)
        
        query.append(self.MIN_STANDING_TACKLE)
        query.append(String(format: "%.0f", self.selectedMinStandingTackle))
        query.append(self.ANPERCENT)
        
        query.append(self.MAX_SLIDING_TACKLE)
        query.append(String(format: "%.0f", self.selectedMaxSlidingTackle))
        query.append(self.ANPERCENT)
        
        query.append(self.MIN_SLIDING_TACKLE)
        query.append(String(format: "%.0f", self.selectedMinSlidingTackle))
        query.append(self.ANPERCENT)
        
        //MARK: Physical
        query.append(self.MAX_PHYSICAL)
        query.append(String(format: "%.0f", self.selectedMaxPhysical))
        query.append(self.ANPERCENT)
        
        query.append(self.MIN_PHYSICAL)
        query.append(String(format: "%.0f", self.selectedMinPhysical))
        query.append(self.ANPERCENT)
       
        query.append(self.MAX_JUMPING)
        query.append(String(format: "%.0f", self.selectedMaxJumping))
        query.append(self.ANPERCENT)
        
        query.append(self.MIN_JUMPING)
        query.append(String(format: "%.0f", self.selectedMinJumping))
        query.append(self.ANPERCENT)
       
        query.append(self.MAX_STAMINA)
        query.append(String(format: "%.0f", self.selectedMaxStamina))
        query.append(self.ANPERCENT)
        
        query.append(self.MIN_STAMINA)
        query.append(String(format: "%.0f", self.selectedMinStamina))
        query.append(self.ANPERCENT)
       
        query.append(self.MAX_STRENGTH)
        query.append(String(format: "%.0f", self.selectedMaxStrength))
        query.append(self.ANPERCENT)
        
        query.append(self.MIN_STRENGTH)
        query.append(String(format: "%.0f", self.selectedMinStrength))
        query.append(self.ANPERCENT)
       
        query.append(self.MAX_AGRESSION)
        query.append(String(format: "%.0f", self.selectedMaxAgression))
        query.append(self.ANPERCENT)
        
        query.append(self.MIN_AGRESSION)
        query.append(String(format: "%.0f", self.selectedMinAgression))
        query.append(self.ANPERCENT)
       
        query.append(self.MAX_COMPOSURE)
        query.append(String(format: "%.0f", self.selectedMaxComposure))
        query.append(self.ANPERCENT)
        
        query.append(self.MIN_COMPOSURE)
        query.append(String(format: "%.0f", self.selectedMinComposure))
        query.append(self.ANPERCENT)
       
        
        

        //MARK: Overall Rating
        query.append(self.MAX_RATING)
        query.append(String(format: "%.0f", self.selectedMaxRating))
        query.append(self.ANPERCENT)
        
        query.append(self.MIN_RATING)
        query.append(String(format: "%.0f", self.selectedMinRating))
//        query.append(self.ANPERCENT)
        return query
    }
    
    private func getNationsQuery() -> String? {
        let s = self.selectedNations.count
        if s == 0 {
            return nil
        } else {
            var query = ""
            for (index, element) in self.selectedNations.enumerated() {
                query.append(self.NATIONS)
                query.append(element.id)
                if index + 1 != s {
                    query.append(self.ANPERCENT)
                }
            }
            return query
        }
    }
    
    private func getLeaguesQuery() -> String? {
        let s = self.selectedLeagues.count
        if s == 0 {
            return nil
        } else {
            var query = ""
            for (index, element) in self.selectedLeagues.enumerated() {
                query.append(self.LEAGUES)
                query.append(element.id)
                if index + 1 != s {
                    query.append(self.ANPERCENT)
                }
            }
            return query
        }
    }
    
    
    private func getTeamsQuery() -> String? {
        let s = self.selectedTeams.count
        if s == 0 {
            return nil
        } else {
            var query = ""
            for (index, element) in self.selectedTeams.enumerated() {
                query.append(self.TEAMS)
                query.append(element.id)
                if index + 1 != s {
                    query.append(self.ANPERCENT)
                }
            }
            return query
        }
    }
    
    
    private func getPositionsQuery() -> String? {
        let s = self.selectedPositions.count
        if s == 0 {
            return nil
        } else {
            var query = ""
            for (index, element) in self.selectedPositions.enumerated() {
                query.append(self.POSITIONS)
                query.append(element.id.lowercased())
                if index + 1 != s {
                    query.append(self.ANPERCENT)
                }
            }
            return query
        }
    }

    private func getAttWorkRatesQuery() -> String? {
        let s = self.selectedAttWorkRates.count
        if s == 0 {
            return nil
        } else {
            var query = ""
            for (index, element) in self.selectedAttWorkRates.enumerated() {
                query.append(self.ATT_WR)
                query.append(element.id)
                if index + 1 != s {
                    query.append(self.ANPERCENT)
                }
            }
            return query
        }
    }

    private func getDefWorkRatesQuery() -> String? {
        let s = self.selectedDefWorkRates.count
        if s == 0 {
            return nil
        } else {
            var query = ""
            for (index, element) in self.selectedDefWorkRates.enumerated() {
                query.append(self.DEF_WR)
                query.append(element.id)
                if index + 1 != s {
                    query.append(self.ANPERCENT)
                }
            }
            return query
        }
    }
    
    private func getSkillMovesQuery() -> String? {
        let s = self.selectedSkills.count
        if s == 0 {
            return nil
        } else {
            var query = ""
            for (index, element) in self.selectedSkills.enumerated() {
                query.append(self.SKILL_MOVES)
                query.append(element.id)
                if index + 1 != s {
                    query.append(self.ANPERCENT)
                }
            }
            return query
        }
    }
    
    private func getWeakFootQuery() -> String? {
        let s = self.selectedWeakFoots.count
        if s == 0 {
            return nil
        } else {
            var query = ""
            for (index, element) in self.selectedWeakFoots.enumerated() {
                query.append(self.WEAK_FOOT)
                query.append(element.id)
                if index + 1 != s {
                    query.append(self.ANPERCENT)
                }
            }
            return query
        }
    }
}
