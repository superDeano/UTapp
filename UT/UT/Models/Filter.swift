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
    
    @Published public var selectedLeagues: Set<GenericKeyValue> = Set()
    @Published public var selectedTeams: Set<GenericKeyValue> = Set()
    @Published public var selectedPositions: Set<GenericValue> = Set()
    @Published public var selectedAttWorkRates: Set<GenericValue> = Set()
    @Published public var selectedDefWorkRates: Set<GenericValue> = Set()
    @Published public var selectedSkills: Set<GenericValue> = Set()
    @Published public var selectedWeakFoots: Set<GenericValue> = Set()
    @Published public var selectedNations: Set<GenericKeyValue> = Set()
    @Published public var selectedAccelerate: String? = nil
    
    @Published public var selectedMinRating: Double = 1
    @Published public var selectedMaxRating: Double = 99
    @Published public var selectedMinPace: Double = 1
    @Published public var selectedMaxPace: Double = 99
    @Published public var selectedMinShooting: Double = 1
    @Published public var selectedMaxShooting: Double = 99
    @Published public var selectedMinPassing: Double = 1
    @Published public var selectedMaxPassing: Double = 99
    @Published public var selectedMinDribbling: Double = 1
    @Published public var selectedMaxDribbling: Double = 99
    @Published public var selectedMinDefending: Double = 1
    @Published public var selectedMaxDefending: Double = 99
    @Published public var selectedMinPhysical: Double = 1
    @Published public var selectedMaxPhysical: Double = 99
    
    func getAllPositions() -> [GenericValue] {
        return [GenericValue(value: "Attackers"),GenericValue(value: "Midfielders"),GenericValue(value: "Defenders"), GenericValue(value: "GK"), GenericValue(value: "LB"), GenericValue(value: "LWB"), GenericValue(value: "CB"), GenericValue(value: "RB"), GenericValue(value: "RWB"), GenericValue(value: "CDM"), GenericValue(value: "CM"), GenericValue(value: "CAM"), GenericValue(value: "LM"), GenericValue(value: "RM"), GenericValue(value: "LW"), GenericValue(value: "RW"), GenericValue(value: "CF"), GenericValue(value: "ST")]
    }
    
    func getAllLeagues() -> [GenericKeyValue] {
        return Leagues.leagues.map { (k: String, val: String) in
            GenericKeyValue(key: k, value: val)
        }
    }
    
    func getSpecificTeams() -> [GenericKeyValue] {
        var teams = [GenericKeyValue]()
        for (_, val) in self.selectedLeagues.enumerated() {
            let teamsInLeague: [String] = Leagues.leaguesAndClubs[val.id] ?? []
            for teamId in teamsInLeague {
                teams.append(GenericKeyValue(key: teamId, value: Clubs.teams[teamId] ?? ""))
            }
        }
        return teams
    }
    
    func getAllWorkRates() -> [GenericValue]{
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
    
    func getAllNations() -> [GenericKeyValue] {
        return Nations.nations.map { (k: String, val: String) in
            GenericKeyValue(key: k, value: val)
        }.sorted(by: {$0.value < $1.value})
    }
    
    func getStarRatings() -> [GenericValue]{
        return [
            GenericValue(value: "5"),
            GenericValue(value: "4"),
            GenericValue(value: "3"),
            GenericValue(value: "2"),
            GenericValue(value: "1")
        ]
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
        query.append(self.MAX_PACE)
        query.append(String(format: "%.0f", self.selectedMaxPace))
        query.append(self.ANPERCENT)
        
        query.append(self.MIN_PACE)
        query.append(String(format: "%.0f", self.selectedMinPace))
        query.append(self.ANPERCENT)
        
        query.append(self.MAX_SHOOTING)
        query.append(String(format: "%.0f", self.selectedMaxShooting))
        query.append(self.ANPERCENT)
        
        query.append(self.MIN_SHOOTING)
        query.append(String(format: "%.0f", self.selectedMinShooting))
        query.append(self.ANPERCENT)
        
        query.append(self.MAX_PASSING)
        query.append(String(format: "%.0f", self.selectedMaxPassing))
        query.append(self.ANPERCENT)
        
        query.append(self.MIN_PASSING)
        query.append(String(format: "%.0f", self.selectedMinPassing))
        query.append(self.ANPERCENT)
        
        query.append(self.MAX_DRIBBLING)
        query.append(String(format: "%.0f", self.selectedMaxDribbling))
        query.append(self.ANPERCENT)
        
        query.append(self.MIN_DRIBBLING)
        query.append(String(format: "%.0f", self.selectedMinDribbling))
        query.append(self.ANPERCENT)
        
        query.append(self.MAX_DEFENSE)
        query.append(String(format: "%.0f", self.selectedMaxDefending))
        query.append(self.ANPERCENT)
        
        query.append(self.MIN_DEFENSE)
        query.append(String(format: "%.0f", self.selectedMinDefending))
        query.append(self.ANPERCENT)
        
        query.append(self.MAX_PHYSICAL)
        query.append(String(format: "%.0f", self.selectedMaxPhysical))
        query.append(self.ANPERCENT)
        
        query.append(self.MIN_PHYSICAL)
        query.append(String(format: "%.0f", self.selectedMinPhysical))
        query.append(self.ANPERCENT)

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
