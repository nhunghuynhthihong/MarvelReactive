//
//  APIResponse.swift
//  MarvelReactive
//
//  Created by Ecko Huynh on 10/14/20.
//

import Foundation

struct APIResponse<T:Decodable>: Decodable {
    let responseCode: Int
    let responseMessage: String
    let data: T
    
    private enum CodingKeys : String, CodingKey {
        case responseCode = "code"
        case responseMessage = "status"
        case data
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        responseCode = try container.decode(Int.self, forKey: .responseCode)
        responseMessage = try container.decode(String.self, forKey: .responseMessage)
        data = try container.decode(T.self, forKey: .data)
    }
}
struct PageResponse<T: Decodable>: Decodable {
    let offset: Int
    let limit: Int
    let count: Int
    let total: Int
    let results: [T]
    
    private enum CodingKeys : String, CodingKey {
        case offset, limit, count, total, results
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        offset = try container.decode(Int.self, forKey: .offset)
        limit = try container.decode(Int.self, forKey: .limit)
        count = try container.decode(Int.self, forKey: .count)
        total = try container.decode(Int.self, forKey: .total)
        results = try container.decode([T].self, forKey: .results)
    }
}
extension Data {
    func decode<T: Decodable>() throws -> T {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: self)
    }
}
