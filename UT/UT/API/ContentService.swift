//
//  ContentService.swift
//  UT
//
//  Created by Dean Chong San on 2024-01-03.
//
import Combine
import Foundation

class ContentService {
    
    let baseUrl = "https://www.futwiz.com/"
    static let baseContentUrl = "https://cdn.futwiz.com/assets/img/fc24/"
    
    func getLatestPlayers(finished: @escaping(([Player]) -> Void)) -> Void {
        guard let url = URL(string: "\(baseUrl)en/fc24/players/latest?appreq") else { return }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request,completionHandler: {data, response, error in
            if let data = data {
                //                let decoder = JSONDecoder()
                //                do {
                //                    let da = try decoder.decode([Player].self, from: data)
                //                } catch {
                //                    print(error)
                //                    fatalError(error.localizedDescription)
                //                }
                let decodedData = try? JSONDecoder().decode([Player].self, from: data)
                let players = decodedData ?? [Player]()
                finished(players)
                //                    fatalError("Error happened when decoding latest players.")
                //                    print("Error happened when decoding latest players.")
                //                }
            } else if let error = error {
                print("Error happened during call to get latest players. \(error)")
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
//        _ = URLSession.shared.dataTaskPublisher(for: url)
//            .map(\.data)
//            .decode(type: RootPlayerStats.self, decoder: JSONDecoder())
//            .sink(receiveCompletion: { result in
//                print(result)
//            }, receiveValue: { playerData in
//                finished(playerData.playerStats)
//            })
    }
    
    func getLowestBin(for lineId: String,finished: @escaping((LowestBin) -> Void)) -> Void {
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
    
    func getStatsAndLowestBin(for lineId: String,finished: @escaping((PlayerStats, LowestBin) -> Void)) -> Void {
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
