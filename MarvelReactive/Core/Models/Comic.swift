//
//  Movie.swift
//  MarvelReactive
//
//  Created by Ecko Huynh on 10/13/20.
//

import Foundation

struct Comic: Decodable, Identifiable {
    
    public let id: Int64
    public let title: String
    var thumbnail: Thumbnail?
    var description: String?
 
    private enum CodingKeys : String, CodingKey {
        case id
        case title
        case description
        case thumbnail
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int64.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        thumbnail = try container.decodeIfPresent(Thumbnail.self, forKey: .thumbnail)
    }
}
struct Thumbnail: Decodable {
    var path: URL
    let `extension`: String
    var url: URL { path.appendingPathExtension(`extension`) }
}
