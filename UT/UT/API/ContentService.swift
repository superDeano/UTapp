//
//  ContentService.swift
//  UT
//
//  Created by Dean Chong San on 2024-01-03.
//

import Foundation

class ContentService {

    let baseUrl = "https://www.futwiz.com/"
    
    
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
//        return players
    }
}
