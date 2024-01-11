//
//  ItemInfo.swift
//  UT
//
//  Created by Dean Chong San on 2024-01-09.
//

import Foundation

public class ItemInfo {
    public var backgroundImage: String
    public var color: String
    public var names: [String]
    
    init(backgroundImage: String, color: String, names: [String]) {
        self.backgroundImage = backgroundImage
        self.color = color
        self.names = names
    }
    
    init() {
        self.backgroundImage = ""
        self.color = ""
        self.names = [String]()
    }
    
    public func toString() -> String {
        return """
{
   backgroundImage: \(self.backgroundImage)
   color: \(self.color)
   names: \(self.names)
}
"""
    }
}
