//
//  Character.swift
//  MarvelReactive
//
//  Created by Ecko Huynh on 10/13/20.
//

import Foundation

struct Character {
    var items: [CharacterSummary]?
}
struct CharacterSummary {
    var resourceURI: String?
    var name: String?
    var role: String?
}
