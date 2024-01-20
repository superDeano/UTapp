//
//  ContentService.swift
//  UT
//
//  Created by Dean Chong San on 2024-01-03.
//
import Combine
import Foundation

class ContentService {

    public static let shared: ContentService = {
        let instance = ContentService()
        return instance
    }()
    
    public var itemManager: GetItemInfo
    
    
    init() {
        self.itemManager = GetItemInfo()
    }
    
    public let baseUrl = "https://www.futwiz.com/"
    public static let baseContentUrl = "https://cdn.futwiz.com/assets/img/fc24/"
    public static let itemsUrl = "https://www.futwiz.com/app/items24.txt"
    public static let goldRareCardUrl = "https://cdn.futwiz.com/assets/img/fc24/items/small/fc24-gold-2.png"
    
    func getLatestPlayers(finished: @escaping(([Player]) -> Void)) -> Void {
        guard let url = URL(string: "\(baseUrl)en/fc24/players/latest?appreq") else { return }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request, completionHandler: {data, response, error in
            if let data = data {

                let decodedData = try? JSONDecoder().decode([Player].self, from: data)
                let players = decodedData ?? [Player]()
                finished(players)
            
            } else if let error = error {
                print("Error happened during call to get latest players. \(error)")
            }
        })
        task.resume()
    }
    
    func getPopularPlayers(finished: @escaping(([Player]) -> Void)) -> Void{
        guard let url = URL(string: "\(baseUrl)en/popular?appreq") else { return }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request, completionHandler: {
            data, res, err in
            if let data = data {
                let decodedData = try? JSONDecoder().decode([Player].self, from: data)
                let players = decodedData ?? [Player]()
                finished(players)
            } else if let error = err {
                print("Error happened during call to get popular players \n \(error)")
            }
        })
        task.resume()
    }
    
    func getPlayerStats(for lineId: String, finished: @escaping((PlayerStats) -> Void)) -> Void {
        guard let url = URL(string: "\(baseUrl)en/app/sold24/\(lineId)/console") else { return }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request,completionHandler: {data, response, error in
            if let data = data {
                let decodedData = try? JSONDecoder().decode(RootPlayerStats.self, from: data)
                let player = decodedData ?? RootPlayerStats()
                finished(player.playerStats)
            } else if let error = error {
                print("Error happened during call to player prices. \(error)")
            }
        })
        task.resume()
    }
    
    func getLowestBin(for lineId: String, finished: @escaping((LowestBin) -> Void)) -> Void {
        guard let url = URL(string: "\(baseUrl)en/app/sold24/\(lineId)/console") else { return }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request,completionHandler: {data, response, error in
            if let data = data {
                let decodedData = try? JSONDecoder().decode(RootLowestBin.self, from: data)
                let rootLowestBin = decodedData ?? RootLowestBin()
                finished(rootLowestBin.lowestBin)
            } else if let error = error {
                print("Error happened during call to player lowest bin. \(error)")
            }
        })
        task.resume()
    }
    
    func getStatsAndLowestBin(for lineId: String, finished: @escaping((PlayerStats, LowestBin) -> Void)) -> Void {
        guard let url = URL(string: "\(baseUrl)en/app/sold24/\(lineId)/console") else { return }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request, completionHandler: {data, response, error in
            if let data = data {
                let decodedBin = try? JSONDecoder().decode(RootTest.self, from: data)
//                let decodedStats = try? JSONDecoder().decode(RootPlayerStats.self, from: data)
                if decodedBin == nil {
                    print("Null data for", lineId)
                }
//                let rootLowestBin = decodedBin ?? RootLowestBin()
//                let rootStats = decodedStats ?? RootPlayerStats()
                finished(decodedBin?.stats ?? PlayerStats(), decodedBin?.lowBin ?? LowestBin())
            } else if let error = error {
                print("Error happened during call to player lowest bin. \(error)")
            }
        })
        task.resume()
    }
    
    public func searchPlayer(for name: String, finished: @escaping (([Player]) -> Void)) -> Void {
        guard let url = URL(string: "\(baseUrl)en/searches/player24/\(name)") else { return }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, err in
            if let data = data {
                let decodedData = try? JSONDecoder().decode([SearchedPlayer].self, from: data)
                var searchedPlayers = [Player]()
                decodedData?.forEach({ sP in
                    searchedPlayers.append(Player(for: sP))
                })
                finished(searchedPlayers)
            }
        }
        task.resume()
    }
    
    public func searchPlayers(filter query: String, page number: Int, finished: @escaping (([Player]) -> Void)) -> Void {
        guard let url = URL(string: "\(baseUrl)en/fc24/players?page=\(number)&\(query)&appreq") else { return }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, err in
            if let data = data {
                let decodedData = try? JSONDecoder().decode([Player].self, from: data)
                finished(decodedData ?? [Player]())
            }
        }
        task.resume()
    }
    
    public func testConnection() -> Void {
        searchPlayer(for: "emir-tintis") { p in
            if p.first?.itemInfo == nil {
                print("Item info is nil")
            } else {
                print("Obtained item info")
            }
        }
    }
    
    public func getCardVersions(finished: @escaping (([GenericKeyValue]) -> Void)) -> Void {
        guard let url = URL(string: "\(baseUrl)en/app/cardTypes24") else { return }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) {
            data, response, err in
            if let data = data {
                let decodedData = try? JSONDecoder().decode([CardType].self, from: data)
                var cardValues = [GenericKeyValue(key: "commongold", value: "Gold"), GenericKeyValue(key: "informsilver", value: "Inform Silver"), GenericKeyValue(key: "raresilver", value: "Rare Silver"), GenericKeyValue(key: "commonsilver", value: "Common Silver"), GenericKeyValue(key: "commonbronze", value: "Common Bronze"), GenericKeyValue(key: "rarebronze", value: "Rare Bronze")]
                for card in decodedData ?? [] {
                    if card.rare == "0" {
                        continue
                    } else if card.rare == "3"{
                        cardValues.append(GenericKeyValue(key: card.rare, value: "Inform Gold"))
                    } else {
                        cardValues.append(GenericKeyValue(key: card.rare, value: card.name))
                    }
                }
                cardValues.sort { $0.value < $1.value }
                finished(cardValues)
            }
        }
        task.resume()
    }
    
    
    public static func getPlayerFacesUrl() -> String {
        return baseContentUrl + "faces/"
    }
    public static func getLeagueLogosUrl() -> String {
        return baseContentUrl + "leagues/"
    }
    public static func getCountryFlagsUrl() -> String {
        return baseContentUrl + "flags/"
    }
    public static func getCardImagesUrl() -> String {
        return baseContentUrl + "items/"
    }
    public static func getClubLogosUrl() -> String {
        return baseContentUrl + "badges/"
    }
}
