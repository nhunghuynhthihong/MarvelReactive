//
//  GetComicsAPI.swift
//  MarvelReactive
//
//  Created by Ecko Huynh on 10/14/20.
//

import Foundation
struct GetComicsAPI: API {
    
}
// MARK: RequestPayload
extension GetComicsAPI {
    struct RequestPayload: RequestPayloadProtocol {
        
        var endpoint: String {
            return "comics"
        }
        
        var query: [URLQueryItem]? {
            return [
                .init(name: "apikey", value: APIKeys.APIKey),
                .init(name: "ts", value: "1"),
                .init(name: "hash", value: APIKeys.HashKey)
            ]
        }
    }
}
// MARK: ResponsePayload
extension GetComicsAPI {
    struct ResponsePayload: ResponsePayloadProtocol {
        let comicsResponse: APIResponse<PageResponse<Comic>>
        
        init(from decoder: Decoder) throws {
            comicsResponse = try decoder.singleValueContainer().decode(APIResponse.self)
        }
    }
}
