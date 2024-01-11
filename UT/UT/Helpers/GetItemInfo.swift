//
//  GetItemLinks.swift
//  UT
//
//  Created by Dean Chong San on 2024-01-09.
//

import Foundation


class GetItemInfo: ObservableObject {
    var items: [ItemInfo]
    
    init() {
        self.items = [ItemInfo]()
        Task.init {
            await self.retrieveContent()
        }
    }
    
    private func retrieveContent() async {
        let url = URL(string: ContentService.itemsUrl)!
        do {
            let (fileUrl, _) = try await URLSession.shared.download(from: url)
            let fileContent = try String(contentsOf: fileUrl)
//            let fileC
            self.createObjects(lines: fileContent.components(separatedBy: .newlines))
        } catch {
            print(error)
        }
    }
    
    private func createObjects(lines: [String]) {
        var item: ItemInfo = ItemInfo()
        for line in lines {
            if line.contains("{") {
                item = ItemInfo()
                var potentialNames = line.components(separatedBy: [" ", ","])
                potentialNames.removeAll { str in
                    str.isEmpty || str == " " || str == "{"
                }
                potentialNames.forEach { s in
                    if s.contains(".") {
                        item.names.append(s.replacingOccurrences(of: ".", with: ""))
                    }
                }
            } else if line.contains(";") {
                // background:url
                if line.contains(":url(") {
                    item.backgroundImage = line
                        .replacingOccurrences(of: "background", with: "")
                        .replacingOccurrences(of: "-image", with: "")
                        .replacingOccurrences(of: ":url(", with: "")
                        .replacingOccurrences(of: ");", with: "")
                        .replacingOccurrences(of: " ", with: "")
                } else if line.contains("color:") {
                    item.color = line
                        .replacingOccurrences(of: "color:", with: "")
                        .replacingOccurrences(of: " ", with: "")
                        .replacingOccurrences(of: ";", with: "")
                }
            } else if line.contains("}"){
                if item.backgroundImage != "" {
                    self.items.append(item)
                }
            }
        }
//        print("Computed result (items):")
//        self.items.forEach { i in
//            print(i.toString())
//        }
        print("Got items")
    }
    
    public func getItemInfo(for name: String) -> ItemInfo? {
        for item in items {
            if item.names.contains(name) {
                return item
            }
        }
        return nil
    }
}
