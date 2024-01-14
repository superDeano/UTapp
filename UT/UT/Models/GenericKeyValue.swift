//
//  League.swift
//  UT
//
//  Created by Dean Chong San on 2024-01-12.
//

import Foundation

struct GenericKeyValue: Identifiable, Hashable, Equatable {
    var id: String { key }
    var key: String
    var value: String
}
